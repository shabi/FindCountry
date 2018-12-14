//
//  AppDataManager.swift
//  ShopOnGo
//
//  Created by eCOM-shabi.naqvi on 06/05/18.
//  Copyright © 2018 shabi. All rights reserved.
//

import Foundation

class AppDataManager {
    
    static let shared = AppDataManager()
    var userId: String?
    var shopId: String?
    
    
    //Singleton class
    private init() {
    }
    
    
    func buildAppData() {
//        self.userAccessToken = AZAuthTokenResponse.retrieveFromKeyChain()
    }
    
    
}

