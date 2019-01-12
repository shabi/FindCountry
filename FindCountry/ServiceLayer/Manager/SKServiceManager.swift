//
//  SKServiceManager.swift
//  ShopOnGo
//
//  Created by Shabi Naqvi on 07/05/18
//  Copyright (c) shabi. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireImage

public class SKServiceManager {
    
    //MARK: - Properties
    public static let shared = SKServiceManager()
    private var configuration = SKServiceConfigauration()
    private var currentRequest: Alamofire.Request?
    
    private var serviceType: String = ""
    private var delegate: SKServiceManagerDelegate?
    private var datasource: SKServiceManagerDataSource?
    
    /// Reachability status of network calls
    weak public private(set) var reachability = NetworkReachabilityManager(host: "www.apple.com")
    
    //MARK: - Initializer method
    
    /// Initializer method for Service Manager class
    @discardableResult
    public init(dataSource: SKServiceManagerDataSource? = nil, delegate: SKServiceManagerDelegate? = nil,
                serviceType: String? = nil) {
        
        // Initializations
        self.initializeNetworkReachability()
        
        self.serviceType = serviceType ?? ""
        self.datasource = dataSource
        self.delegate = delegate
        
        // URL
        let requestURLAndMethodType = self.datasource?.requestUrlandHttpMethodType(serviceType: serviceType ?? "")
        let url = requestURLAndMethodType?.url
        
        // HTTP Method
        var httpMethodType : Alamofire.HTTPMethod? = .get
        if let requestMethodType = requestURLAndMethodType?.methodType {
            httpMethodType = Alamofire.HTTPMethod(rawValue: requestMethodType.rawValue)
        }
        
        // Headers
        let headers: [String: String]? = configuration.addCustomHeaders(customHeaders: self.datasource?.requestHeaders(serviceType: serviceType ?? ""))
        
        // Parameters
        let parameters: [String: AnyObject]? = self.datasource?.requestParameters(serviceType: serviceType ?? "")
        
        if Utility.isNilOrEmpty(string: url as NSString?) {
            self.handleFailure(error: Utility.createErrorInstance(title: "Improper URL", message: "Please check the url you have requested", errorCode: 401))
        } else {
            self.processServiceRequest(method: httpMethodType, url: url, headers: headers, parameters: parameters)
        }
        self.datasource = nil
    }
    
    fileprivate func initializeNetworkReachability() {
        
        self.reachability?.listener = { [weak self] status in
            print("Network Status Changed: \(status)")
            guard let strongSelf = self else {
                return
            }
            switch status {
            case .notReachable:
                print("Not Reachable")
                strongSelf.cancelRequest(message: "Please check your internet connection or try again later")
            case .unknown:
                print("UnKnown")
            case .reachable(let connectionType):
                
                if connectionType == .ethernetOrWiFi {
                    print("Reachable Wifi")
                }
                else {
                    print("Reachable wwan")
                }
            }
        }
        
        self.reachability?.startListening()
    }
    
    //MARK: - Service Request - Alamofire
    /// This method creates a ‘Request’
    func processServiceRequest(method: Alamofire.HTTPMethod?, url : String?,
                               headers: [String : String]?,
                               parameters : [String : AnyObject]?) {
        
        
        
        let escapedString = url?.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        let destinationURL = URL(string: escapedString!)
        self.currentRequest =  Alamofire.request(destinationURL!, method: method!, parameters: parameters,
                                                 encoding: JSONEncoding.default, headers: headers)
            .responseString { response in
                switch(response.result) {
                case .success:
                    if let urlResponse = response.response, let stringResult = response.result.value {
                        let serializer = DataRequest.jsonResponseSerializer()
                        var data = stringResult.data(using: .utf8)!
                        if stringResult.count <= 0 {
                            data = "{}".data(using: .utf8)!
                        }
                        let result = serializer.serializeResponse(response.request, response.response, data, nil)
                        if result.isSuccess {
                            //If Authorization failed or token expired :: Refresh token
                            if urlResponse.statusCode == 401 {
                                self.currentRequest = nil
                            } else {
                                self.processSuccessResponse(header: urlResponse, response: result.value)
                            }

                        } else {
                            self.handleFailure(error: result.error, failureResponse: response)
                        }
                    }
                case .failure(let error):
                    self.handleFailure(error: error, failureResponse: response)
                }
                self.currentRequest = nil
        }
    }
    
    
    //MARK: - Success and Failure - Alamofire
    
    func processSuccessResponse(header: HTTPURLResponse?, response: Any?) {
        self.delegate?.didReceiveResponse(serviceType: self.serviceType, headerResponse: header, finalResponse: response)
        self.delegate = nil
    }
    
    func handleFailure(error:Error?, failureResponse: Any? = nil) {
        self.delegate?.didReceiveError(serviceType: self.serviceType, theError: error, failureResponse: failureResponse)
        self.delegate = nil
    }
    
    //MARK: - Cancelling requests - Alamofire
    
    public func cancelRequest(message: String = "Something went wrong, Kindly retry after sometime.") {
        self.currentRequest?.cancel()
        self.currentRequest = nil
    }
}
