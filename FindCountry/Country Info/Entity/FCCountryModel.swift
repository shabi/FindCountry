//
//  FCCountryModel.swift
//  ShopOnGo
//
//  Created by eCOM-shabi.naqvi on 14/11/18.
//  Copyright © 2018 shabi. All rights reserved.
//

import Foundation
import SwiftyJSON

public class FCCountryModel : FCModelMappable {
    
    // MARK: Declaration for string constants to be used to decode and also serialize.
    private struct SerializationKeys {
        static let name = "name"
        static let topLevelDomain = "topLevelDomain"
        static let alpha2Code = "alpha2Code"
        static let alpha3Code = "alpha3Code"
        static let callingCodes = "callingCodes"
        static let capital = "capital"
        static let altSpellings = "altSpellings"
        static let region = "region"
        static let subregion = "subregion"
        static let population = "population"
        static let latlng = "latlng"
        static let demonym = "demonym"
        static let area = "area"
        static let gini = "gini"
        static let timezones = "timezones"
        static let borders = "borders"
        static let nativeName = "nativeName"
        static let numericCode = "numericCode"
        static let currencies = "currencies"
        static let languages = "languages"
        static let translations = "translations"
        static let flag = "flag"
        static let regionalBlocs = "regionalBlocs"
        static let cioc = "cioc"
    }
    
    public var name : String?
    public var topLevelDomain : [String]?
    public var alpha2Code : String?
    public var alpha3Code : String?
    public var callingCodes : [String]?
    public var capital : String?
    public var altSpellings : [String]?
    public var region : String?
    public var subregion : String?
    public var population : Int?
    public var latlng : [Int]?
    public var demonym : String?
    public var area : Int?
    public var gini : String?
    public var timezones : [String]?
    public var borders : [String]?
    public var nativeName : String?
    public var numericCode : String?
    public var currencies : [Currencies]?
    public var languages : [Languages]?
    public var translations : Translations?
    public var flag : String?
    public var regionalBlocs : [RegionalBlocs]?
    public var cioc : String?
    

    // MARK: SwiftyJSON Initializers
    /// Initiates the instance based on the object.
    ///
    /// - parameter object: The object of either Dictionary or Array kind that was passed.
    /// - returns: An initialized instance of the class.
    public convenience init(object: Any) {
        self.init(json: JSON(object))
    }
    
    /// Initiates the instance based on the JSON that was passed.
    ///
    /// - parameter json: JSON object from SwiftyJSON.
    public required init(json: JSON) {
        name = json[SerializationKeys.name].string
        if let items = json[SerializationKeys.topLevelDomain].array { topLevelDomain = items.map { $0.object} as? [String] }
        alpha2Code = json[SerializationKeys.alpha2Code].string
        alpha3Code = json[SerializationKeys.alpha3Code].string
        if let items = json[SerializationKeys.callingCodes].array { callingCodes = items.map { $0.object} as? [String] }
        capital = json[SerializationKeys.capital].string
        if let items = json[SerializationKeys.altSpellings].array { altSpellings = items.map { $0.object} as? [String] }
        region = json[SerializationKeys.region].string
        
        subregion = json[SerializationKeys.subregion].string
        population = json[SerializationKeys.population].int
        if let items = json[SerializationKeys.latlng].array { latlng = items.map { $0.object} as? [Int] }

        
        demonym = json[SerializationKeys.demonym].string
        area = json[SerializationKeys.area].int
        gini = json[SerializationKeys.gini].string
        if let items = json[SerializationKeys.timezones].array { timezones = items.map { $0.object} as? [String] }
        if let items = json[SerializationKeys.borders].array { borders = items.map { $0.object} as? [String] }
        nativeName = json[SerializationKeys.nativeName].string
        
        numericCode = json[SerializationKeys.numericCode].string
        if let items = json[SerializationKeys.currencies].array { currencies = items.map { Currencies(json: $0) } }
        if let items = json[SerializationKeys.languages].array { languages = items.map { Languages(json: $0) } }
        translations = Translations(json: json[SerializationKeys.translations])
        flag = json[SerializationKeys.flag].string
        if let items = json[SerializationKeys.regionalBlocs].array { regionalBlocs = items.map { RegionalBlocs(json: $0) } }
        cioc = json[SerializationKeys.cioc].string
    }
    
    /// Generates description of the object in the form of a NSDictionary.
    ///
    /// - returns: A Key value pair containing all valid values in the object.
//    public func dictionaryRepresentation() -> [String: Any] {
//        var dictionary: [String: Any] = [:]
//        if let value = accessToken { dictionary[SerializationKeys.accessToken] = value }
//        if let value = tokenType { dictionary[SerializationKeys.tokenType] = value }
//        if let value = expiresIn { dictionary[SerializationKeys.expiresIn] = value }
//        if let value = name { dictionary[SerializationKeys.name] = value }
//        if let value = role { dictionary[SerializationKeys.role] = value }
//        if let value = userImage { dictionary[SerializationKeys.userImage] = value }
//        if let value = userEmail { dictionary[SerializationKeys.userEmail] = value }
//        if let value = issued { dictionary[SerializationKeys.issued] = value }
//        if let value = expires { dictionary[SerializationKeys.expires] = value }
//        return dictionary
//    }
    
}

