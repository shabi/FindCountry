//
//  FCCountryListAPI.swift
//  ShopOnGo
//
//  Created by eCOM-shabi.naqvi on 14/11/18.
//  Copyright © 2018 shabi. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class FCCountryListAPI {
    
    weak var viewModelDelegate: APIDelegateViewModel?
    var serviceType:  APIConstants.ServiceType = .none
    var country: String?
    
    enum EventType {
        case fetchCountry
    }
    
    let eventType: EventType
    
    init(serviceType: APIConstants.ServiceType, type: EventType, delegateViewModel: APIDelegateViewModel, searchText: String?) {
        self.eventType = type
        self.viewModelDelegate = delegateViewModel
        self.serviceType = serviceType
        self.country = searchText
    }
    
    func event() -> NSNotification.Name {
       return FCUtility.notificationName(name: APIConstants.PostNotify.searchCountryEvent)
    }
    
    func errorEvent() -> NSNotification.Name {
       return FCUtility.notificationName(name: APIConstants.PostNotify.searchCountryError)
    }
    
    func makeModel(json: JSON) -> FCModelMappable? {
        if self.serviceType == APIConstants.ServiceType.getCountry {
            return FCCountryModel(json: json)
        }
        return nil
    }
    
    func fetchData() {
        self.fetchCountryListData()
    }
    
    fileprivate func fetchCountryListData() {
        SKServiceManager(dataSource: self, delegate: self, serviceType: self.serviceType.rawValue)
    }
}

extension FCCountryListAPI: SKServiceManagerDelegate {
    
    func didReceiveError(serviceType: String, theError: Error?, failureResponse: Any?) -> [String : String]? {
        
        if let response = failureResponse {
            serviceResponse(response: response)
            print("failureResponse")
            self.viewModelDelegate?.apiFailure(serviceType: serviceType, error: theError!)
        } else {
            SGProgressView.shared.hideProgressView()
        }
        return nil
    }
    
    func didReceiveResponse(serviceType: String, headerResponse: HTTPURLResponse?,
                            finalResponse:Any?) {
        
        if let response = finalResponse {
            if serviceType == APIConstants.ServiceType.getCountry.rawValue {
                let countryList = FCCountriesFound(object: response)
                self.viewModelDelegate?.apiSuccess(serviceType: serviceType, model: countryList, isFromCache: false)
            }
        } else {
            if let errorMessage = (finalResponse as! NSDictionary)["error_description"] {
                FCUtility.showAlert(title: "Error", message: errorMessage as? String, actionTitles: "OK", actions: nil)
            }
            SGProgressView.shared.hideProgressView()
        }
    }
    
    fileprivate func serviceResponse(response: Any) {
        print("serviceResponse")
        print("response")
    }
}

extension FCCountryListAPI: SKServiceManagerDataSource {
    func requestParameters(serviceType: String) -> [String : AnyObject]? { return nil}
    
    func requestHeaders(serviceType: String) -> [String : String]? {
        print("requestHeaders")
        return nil
    }
    
    // MARK: ServiceKit Datasource
    func requestUrlandHttpMethodType(serviceType: String) -> (url: String?,
        methodType: SKConstant.HTTPMethod?) {
            var urlAndMethodType: (url: String?, methodType: SKConstant.HTTPMethod?)
            if let country = self.country {
                urlAndMethodType.url = APIConstants.ApiUrls.countryUrl + country
            }
            urlAndMethodType.methodType = .get
            return urlAndMethodType
    }
}
