//
//  SKUtility.swift
//  ShopOnGo
//
//  Created by Shabi Naqvi on 07/05/18
//  Copyright (c) shabi. All rights reserved.
//

import Foundation
import UIKit

class Utility {
    
    class func isNilOrEmpty(string: NSString?) -> Bool {
        switch string {
        case .some(let nonNilString): return nonNilString.length == 0
        default:                      return true
        }
    }
    
    class func isEmptyLists(dict: [String: [String]]) -> Bool {
        for list in dict.values {
            if !list.isEmpty { return false }
        }
        return true
    }
    
    class func createErrorInstance(title:String? , message: String? , errorCode: Int) -> Error {
        let userInfo: [AnyHashable: Any] = [
            NSLocalizedDescriptionKey:  NSLocalizedString(title!, value: message!, comment: ""),
            NSLocalizedFailureReasonErrorKey: NSLocalizedString(title!, value: message!, comment: "")
        ]
        return NSError(domain: "ServiceManagerHttpResponseErrorDomain", code: errorCode, userInfo: userInfo as! [String : Any])
    }
}

extension Dictionary {
    func merged(another: [Key: Value]) -> Dictionary {
        var result: [Key: Value] = [:]
        for (key, value) in self {
            result[key] = value
        }
        for (key, value) in another {
            result[key] = value
        }
        return result
    }
}

extension Dictionary where Value: RangeReplaceableCollection {
    func merged(another: [Key: Value]) -> [Key: Value] {
        var result: [Key: Value] = [:]
        for (key, value) in self {
            result[key] = value
        }
        for (key, value) in another {
            if let collection = result[key] {
                result[key] = collection + value
            } else {
                result[key] = value
            }
            
        }
        return result
    }
}

extension UIView {
    func setCellShadow() {
        self.layer.shadowColor = UIColor.darkGray.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 1)
        self.layer.shadowOpacity = 1
        self.layer.shadowRadius = 1
        self.layer.masksToBounds = false
        self.clipsToBounds = false
        self.layer.cornerRadius = 10
    }
}
