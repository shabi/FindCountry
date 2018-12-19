//
//  FCTranslations+CoreDataProperties.swift
//  
//
//  Created by eCOM-shabi.naqvi on 17/12/18.
//
//

import Foundation
import CoreData


extension FCTranslations {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FCTranslations> {
        return NSFetchRequest<FCTranslations>(entityName: "FCTranslations")
    }

    @NSManaged public var de: String?
    @NSManaged public var es: String?
    @NSManaged public var fr: String?
    @NSManaged public var ja: String?
    @NSManaged public var it: String?
    @NSManaged public var br: String?
    @NSManaged public var pt: String?
    @NSManaged public var nl: String?
    @NSManaged public var hr: String?
    @NSManaged public var fa: String?

}
