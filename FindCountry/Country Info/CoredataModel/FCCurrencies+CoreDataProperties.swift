//
//  FCCurrencies+CoreDataProperties.swift
//  
//
//  Created by eCOM-shabi.naqvi on 17/12/18.
//
//

import Foundation
import CoreData


extension FCCurrencies {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FCCurrencies> {
        return NSFetchRequest<FCCurrencies>(entityName: "FCCurrencies")
    }

    @NSManaged public var code: String?
    @NSManaged public var name: String?
    @NSManaged public var symbol: String?

}
