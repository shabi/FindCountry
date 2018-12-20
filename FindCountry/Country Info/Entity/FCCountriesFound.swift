//
//  FCCountriesFound.swift
//  FindCountry
//
//  Created by eCOM-shabi.naqvi on 15/12/18.
//  Copyright © 2018 shabi. All rights reserved.
//

import Foundation
import SwiftyJSON

public class FCCountriesFound : FCModelMappable {
    
    // MARK: Declaration for string constants to be used to decode and also serialize.
    private struct SerializationKeys {
        static let countryInfo = "countryInfo"
    }
    
    public var countryInfo : [FCCountryModel]?

    
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
        if let items = json.array { countryInfo = items.map { FCCountryModel(json: $0) } }
    }
}
