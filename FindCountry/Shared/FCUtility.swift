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
    
    // MARK: Validating regex, returns boolean true or false
    
    public class func checkRegex(data: String, regex: String) -> Bool {
        if let regex = try? NSRegularExpression(pattern: regex, options: []) {
            return regex.matches(in: data, options: [],
                                 range: NSRange(location: 0, length: data.count)).count > 0
        }
        return false
    }
    
    // MARK: Check if its a iPad Device
    
    public class func isIpadDevice() -> Bool {
        let deviceType: String = UIDevice.current.model.lowercased()
        return self.checkRegex(data: deviceType, regex: SGConstants.iPadDeviceRgx)
    }
    
    // MARK: Check if its a New Device
    
    public class func isNewDevice() -> Bool {
        let deviceType: String = UIDevice.current.model.lowercased()
        return self.checkRegex(data: deviceType, regex: SGConstants.newDeviceRgx)
    }
    
    // MARK: Color from hex
    
    public class func readJson(fileName: String) -> Any? {
        do {
            if let file = Bundle.main.url(forResource: fileName, withExtension: "json") {
                let data = try Data(contentsOf: file)
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                return json
            }
        } catch { print(error.localizedDescription) }
        return nil
    }
    
    
    public class func getUrlDomain(server: String?, port: String? = nil,
                                   version: String? = "", urlProtocol: String? = nil) -> String {
        var validUrlProtocol: String? = urlProtocol
        if urlProtocol == nil {
            validUrlProtocol = FCUtility.getBaseProtocol()
        }
        if port == nil {
            return "\(validUrlProtocol! )://\(server ?? "")/\(version ?? "")/"
        }
        return "\(validUrlProtocol!)://\(server ?? ""):\(port ?? "")/\(version ?? "")/"
    }
    
    fileprivate class func getBaseProtocol() -> String {
        //        if case Environment.production = Configuration.appEnvironment {
        //            return "https"
        //        }
        //        return "http"
        return ""
    }
    
    public class func getServiceType(value: String) -> APIConstants.ServiceType {
        if let type = APIConstants.ServiceType(rawValue: value) {
            return type
        } else {
            return .none
        }
    }
    
    
    // MARK: Email Validation
    public class func isValidEmail(text: String) -> Bool {
        // print("validate calendar: \(testStr)")
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: text)
    }
    
    // MARK: ZipCode Validation
    public class func checkZipCodeCharacters(text: String, range: NSRange, string: String) -> Bool {
        
        let currentCharacterCount = text.count
        if (range.length + range.location > currentCharacterCount){
            return false
        }
        let newLength = currentCharacterCount + string.count  - range.length
        return newLength <= 5
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
    
    // MARK: Count Occurences of String
    public class func countOccurrencesOfKey(_ key: String, inArray a: [String]) -> Int {
        func leftBoundary() -> Int {
            var low = 0
            var high = a.count
            while low < high {
                let midIndex = low + (high - low)/2
                if a[midIndex] < key {
                    low = midIndex + 1
                } else {
                    high = midIndex
                }
            }
            return low
        }
        
        func rightBoundary() -> Int {
            var low = 0
            var high = a.count
            while low < high {
                let midIndex = low + (high - low)/2
                if a[midIndex] > key {
                    high = midIndex
                } else {
                    low = midIndex + 1
                }
            }
            return low
        }
        
        return rightBoundary() - leftBoundary()
    }
    
    
    public class func random(_ range:Range<Int>) -> Int
    {
        return range.lowerBound + Int(arc4random_uniform(UInt32(range.upperBound - range.lowerBound)))
    }
    
    

}

// MARK: User Defaults Storage
class UserDefaultsWrapper {
    
    class func getObject(key: String) -> Any? {
        return UserDefaults.standard.object(forKey: key)
    }
    
    class func getInt(key: String) -> Int {
        return UserDefaults.standard.integer(forKey: key)
    }
    
    class func getBool(key: String) -> Bool {
        return UserDefaults.standard.bool(forKey: key)
    }
    
    class func getFloat(key: String) -> Float {
        return UserDefaults.standard.float(forKey: key)
    }
    
    class func getString(key: String) -> String? {
        return UserDefaults.standard.string(forKey: key)
    }
    
    // MARK: Get value with default value
    
    class func getObject(key: String, defaultValue: Any) -> Any? {
        if getObject(key: key) == nil {
            return defaultValue
        }
        return getObject(key: key) as Any
    }
    
    class func getInt(key: String, defaultValue: Int) -> Int {
        if getObject(key: key) == nil {
            return defaultValue
        }
        return getInt(key: key)
    }
    
    class func getBool(key: String, defaultValue: Bool) -> Bool {
        if getObject(key: key) == nil {
            return defaultValue
        }
        return getBool(key: key)
    }
    
    class func getFloat(key: String, defaultValue: Float) -> Float {
        if getObject(key: key) == nil {
            return defaultValue
        }
        return getFloat(key: key)
    }
    
    class func getString(key: String, defaultValue: String) -> String? {
        if getObject(key: key) == nil {
            return defaultValue
        }
        return getString(key: key)
    }
    
    
    // MARK: Set value
    
    class func setObject(key: String, value: Any?) {
        if value == nil {
            UserDefaults.standard.removeObject(forKey: key)
        } else {
            UserDefaults.standard.set(value, forKey: key)
        }
        UserDefaults.standard.synchronize()
    }
    
    class func setModel(key: String, value: Any?) {
        if value == nil {
            UserDefaults.standard.removeObject(forKey: key)
        } else {
            UserDefaults.standard.dictionary(forKey: key)
        }
        UserDefaults.standard.synchronize()
    }
    
    class func setInt(key: String, value: Int) {
        UserDefaults.standard.set(value, forKey: key)
        UserDefaults.standard.synchronize()
    }
    
    class func setBool(key: String, value: Bool) {
        UserDefaults.standard.set(value, forKey: key)
        UserDefaults.standard.synchronize()
    }
    
    class func setFloat(key: String, value: Float) {
        UserDefaults.standard.set(value, forKey: key)
        UserDefaults.standard.synchronize()
    }
    
    class func setString(key: String, value: String?) {
        if value == nil {
            UserDefaults.standard.removeObject(forKey: key)
        } else {
            UserDefaults.standard.set(value, forKey: key)
        }
        UserDefaults.standard.synchronize()
    }
    
    // MARK: Synchronize
    
    class func sync() {
        UserDefaults.standard.synchronize()
    }
}


