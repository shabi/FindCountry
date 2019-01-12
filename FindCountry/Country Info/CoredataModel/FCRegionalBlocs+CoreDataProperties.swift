//
//  FCRegionalBlocs+CoreDataProperties.swift
//  
//
//  Created by eCOM-shabi.naqvi on 17/12/18.
//
//

import Foundation
import CoreData


extension FCRegionalBlocs {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FCRegionalBlocs> {
        return NSFetchRequest<FCRegionalBlocs>(entityName: "FCRegionalBlocs")
    }

    @NSManaged public var acronym: String?

}
