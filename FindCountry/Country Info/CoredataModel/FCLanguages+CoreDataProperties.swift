//
//  FCLanguages+CoreDataProperties.swift
//  
//
//  Created by eCOM-shabi.naqvi on 17/12/18.
//
//

import Foundation
import CoreData


extension FCLanguages {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FCLanguages> {
        return NSFetchRequest<FCLanguages>(entityName: "FCLanguages")
    }

    @NSManaged public var name: String?
    @NSManaged public var nativeName: String?

}
