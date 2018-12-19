//
//  FCUtility.swift
//  ShopOnGo
//
//  Created by eCOM-shabi.naqvi on 06/05/18.
//  Copyright © 2018 shabi. All rights reserved.
//

import Foundation
import UIKit
import Security

class FCUtility: NSObject {
    
    static let sharedDelegate = UIApplication.shared.delegate as! AppDelegate
    // MARK: To get Notification Name
    
    public class func notificationName(name: String) -> Notification.Name {
        return NSNotification.Name(rawValue: name)
    }
    
    // MARK: AlertView
    public class func showAlert(title: String? = "", message: String?, actionTitles:String?...,
        actions:[((UIAlertAction) -> Void)?]?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        for (index, title) in actionTitles.enumerated() {
            let action = UIAlertAction(title: title, style: .default, handler: actions?[index])
            alert.addAction(action)
        }
        sharedDelegate.window?.rootViewController?.present(alert, animated: true, completion: nil)
    }
    
    public class func displayAlertInController(controller: UIViewController?,
                                               title: String? = "", message: String?, actionTitles:String?...,
        actions:[((UIAlertAction) -> Void)?]?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        for (index, title) in actionTitles.enumerated() {
            let action = UIAlertAction(title: title, style: .default, handler: actions?[index])
            alert.addAction(action)
        }
        controller?.present(alert, animated: true, completion: nil)
    }
}


