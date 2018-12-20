//
//  SKServiceConfigauration.swift
//  ShopOnGo
//
//  Created by Shabi Naqvi on 07/05/18
//  Copyright (c) shabi. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireImage


class SKServiceConfigauration {
    
    var configuration: URLSessionConfiguration?
    
    func addCustomHeaders(customHeaders:[String: String]?) -> [String: String]? {
        
        var finalheaders: [String: String]
        let headers = Alamofire.SessionManager.defaultHTTPHeaders
        if let customHeaders = customHeaders {
            finalheaders = headers.merged(another: customHeaders)
        }else{
            finalheaders = headers
        }
        self.configuration = URLSessionConfiguration.default
        self.configuration?.timeoutIntervalForRequest = 60
        self.configuration?.httpAdditionalHeaders = finalheaders
        
        return finalheaders
    }
}
