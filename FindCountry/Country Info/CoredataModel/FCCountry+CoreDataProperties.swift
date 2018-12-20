//
//  FCCountry+CoreDataProperties.swift
//  
//
//  Created by eCOM-shabi.naqvi on 17/12/18.
//
//

import Foundation
import CoreData


extension FCCountry {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FCCountry> {
        return NSFetchRequest<FCCountry>(entityName: "FCCountry")
    }

    @NSManaged public var name: String?
    @NSManaged public var capital: String?
    @NSManaged public var region: String?
    @NSManaged public var subRegion: String?
    @NSManaged public var population: Int64
    @NSManaged public var area: Int64
    @NSManaged public var nativeName: String?
    @NSManaged public var flag: String?
    @NSManaged public var altSpellings: [String]?
    @NSManaged public var callingCodes: [String]?
    @NSManaged public var timezones: [String]?
    @NSManaged public var borders: [String]?
    @NSManaged public var currencies: NSOrderedSet?
    @NSManaged public var languages: NSOrderedSet?
    @NSManaged public var translation: FCTranslations?
    @NSManaged public var reginonalBlocs: NSOrderedSet?

}

// MARK: Generated accessors for currencies
extension FCCountry {

    @objc(insertObject:inCurrenciesAtIndex:)
    @NSManaged public func insertIntoCurrencies(_ value: FCCurrencies, at idx: Int)

    @objc(removeObjectFromCurrenciesAtIndex:)
    @NSManaged public func removeFromCurrencies(at idx: Int)

    @objc(insertCurrencies:atIndexes:)
    @NSManaged public func insertIntoCurrencies(_ values: [FCCurrencies], at indexes: NSIndexSet)

    @objc(removeCurrenciesAtIndexes:)
    @NSManaged public func removeFromCurrencies(at indexes: NSIndexSet)

    @objc(replaceObjectInCurrenciesAtIndex:withObject:)
    @NSManaged public func replaceCurrencies(at idx: Int, with value: FCCurrencies)

    @objc(replaceCurrenciesAtIndexes:withCurrencies:)
    @NSManaged public func replaceCurrencies(at indexes: NSIndexSet, with values: [FCCurrencies])

    @objc(addCurrenciesObject:)
    @NSManaged public func addToCurrencies(_ value: FCCurrencies)

    @objc(removeCurrenciesObject:)
    @NSManaged public func removeFromCurrencies(_ value: FCCurrencies)

    @objc(addCurrencies:)
    @NSManaged public func addToCurrencies(_ values: NSOrderedSet)

    @objc(removeCurrencies:)
    @NSManaged public func removeFromCurrencies(_ values: NSOrderedSet)

}

// MARK: Generated accessors for languages
extension FCCountry {

    @objc(insertObject:inLanguagesAtIndex:)
    @NSManaged public func insertIntoLanguages(_ value: FCLanguages, at idx: Int)

    @objc(removeObjectFromLanguagesAtIndex:)
    @NSManaged public func removeFromLanguages(at idx: Int)

    @objc(insertLanguages:atIndexes:)
    @NSManaged public func insertIntoLanguages(_ values: [FCLanguages], at indexes: NSIndexSet)

    @objc(removeLanguagesAtIndexes:)
    @NSManaged public func removeFromLanguages(at indexes: NSIndexSet)

    @objc(replaceObjectInLanguagesAtIndex:withObject:)
    @NSManaged public func replaceLanguages(at idx: Int, with value: FCLanguages)

    @objc(replaceLanguagesAtIndexes:withLanguages:)
    @NSManaged public func replaceLanguages(at indexes: NSIndexSet, with values: [FCLanguages])

    @objc(addLanguagesObject:)
    @NSManaged public func addToLanguages(_ value: FCLanguages)

    @objc(removeLanguagesObject:)
    @NSManaged public func removeFromLanguages(_ value: FCLanguages)

    @objc(addLanguages:)
    @NSManaged public func addToLanguages(_ values: NSOrderedSet)

    @objc(removeLanguages:)
    @NSManaged public func removeFromLanguages(_ values: NSOrderedSet)

}

// MARK: Generated accessors for reginonalBlocs
extension FCCountry {

    @objc(insertObject:inReginonalBlocsAtIndex:)
    @NSManaged public func insertIntoReginonalBlocs(_ value: FCRegionalBlocs, at idx: Int)

    @objc(removeObjectFromReginonalBlocsAtIndex:)
    @NSManaged public func removeFromReginonalBlocs(at idx: Int)

    @objc(insertReginonalBlocs:atIndexes:)
    @NSManaged public func insertIntoReginonalBlocs(_ values: [FCRegionalBlocs], at indexes: NSIndexSet)

    @objc(removeReginonalBlocsAtIndexes:)
    @NSManaged public func removeFromReginonalBlocs(at indexes: NSIndexSet)

    @objc(replaceObjectInReginonalBlocsAtIndex:withObject:)
    @NSManaged public func replaceReginonalBlocs(at idx: Int, with value: FCRegionalBlocs)

    @objc(replaceReginonalBlocsAtIndexes:withReginonalBlocs:)
    @NSManaged public func replaceReginonalBlocs(at indexes: NSIndexSet, with values: [FCRegionalBlocs])

    @objc(addReginonalBlocsObject:)
    @NSManaged public func addToReginonalBlocs(_ value: FCRegionalBlocs)

    @objc(removeReginonalBlocsObject:)
    @NSManaged public func removeFromReginonalBlocs(_ value: FCRegionalBlocs)

    @objc(addReginonalBlocs:)
    @NSManaged public func addToReginonalBlocs(_ values: NSOrderedSet)

    @objc(removeReginonalBlocs:)
    @NSManaged public func removeFromReginonalBlocs(_ values: NSOrderedSet)

}
