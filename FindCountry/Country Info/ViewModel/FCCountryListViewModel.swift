//
//  FCCountryListViewModel.swift
//  ShopOnGo
//
//  Created by eCOM-shabi.naqvi on 14/11/18.
//  Copyright © 2018 shabi. All rights reserved.
//

import Foundation
import SwiftyJSON


class FCCountryListViewModel {
    
    var countryListAPI: FCCountryListAPI?
    weak var viewController: ViewController?
    var countryModel: FCCountryModel?
    var loginInfo: [String: String]?
    
    init(viewController: ViewController, loginInfo: [String: String]?) {
        self.viewController = viewController
        self.loginInfo = loginInfo
    }
    
    func fetchEventInfo(serviceType: APIConstants.ServiceType) {
        if serviceType == .login {
            self.countryListAPI =  FCCountryListAPI(serviceType: .login, type: .fetchLogin, delegateViewModel: self, loginInfo: self.loginInfo)
        } else {
            self.countryListAPI =  FCCountryListAPI(serviceType: .registration, type: .fetchRegistration, delegateViewModel: self, loginInfo: self.loginInfo)
        }
        self.countryListAPI?.fetchData()
        SGProgressView.shared.showProgressView((self.viewController as! UIViewController).view)
    }
}

extension FCCountryListViewModel: APIDelegateViewModel {
    
    func apiSuccess(serviceType: String, model: Any?) {
        
        if serviceType == APIConstants.ServiceType.login.rawValue, let info = model as? FCCountryModel {
            self.countryModel = info
            DispatchQueue.main.async {
                self.viewController?.updateView()
            }
        } else if serviceType == APIConstants.ServiceType.registration.rawValue {
            DispatchQueue.main.async {
                self.viewController?.updateView()
            }
        }

        SGProgressView.shared.hideProgressView()
        print("success")
    }
    
    func apiFailure(serviceType: String, error: Error) {
        print("failue")
        SGProgressView.shared.hideProgressView()
    }
}
