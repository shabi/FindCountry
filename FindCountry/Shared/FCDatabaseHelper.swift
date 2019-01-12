//
//  FCDatabaseHelper.swift
//  FindCountry
//
//  Created by eCOM-shabi.naqvi on 17/12/18.
//  Copyright © 2018 shabi. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class FCDatabaseHelper {
    static let shared = FCDatabaseHelper()
    let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
    
    func save(countryInfo: [FCCountryModel]?) {
        if let countries = countryInfo {
            let _ = countries.map {
                
                let country = NSEntityDescription.insertNewObject(forEntityName: "FCCountry", into: context!) as! FCCountry

                country.name = $0.name
                country.capital = $0.capital
                country.region = $0.region
                
                if let population = $0.population {
                    country.population = Int64(population)
                }
                if let area = $0.area {
                    country.area = Int64(area)
                }
                country.nativeName = $0.nativeName
                country.flag = $0.flag
                country.altSpellings = $0.altSpellings
                country.timezones = $0.timezones
                country.borders = $0.borders

                if let currencies = $0.currencies {
                    let _ = currencies.map {
                        let currency = NSEntityDescription.insertNewObject(forEntityName: "FCCurrencies", into: context!) as! FCCurrencies
                        currency.code = $0.code
                        currency.name = $0.name
                        currency.symbol = $0.symbol
                        let currencies = country.mutableOrderedSetValue(forKey: "currencies")
                        currencies.add(currency)
                    }
                }

                if let languages = $0.languages {
                    let _ = languages.map {
                        let language = NSEntityDescription.insertNewObject(forEntityName: "FCLanguages", into: context!) as! FCLanguages
                        language.name = $0.name
                        language.nativeName = $0.nativeName
                        let languages = country.mutableOrderedSetValue(forKey: "languages")
                        languages.add(language)
                    }
                }
                
                let translation = NSEntityDescription.insertNewObject(forEntityName: "FCTranslations", into: context!) as! FCTranslations
                translation.br = $0.translations?.br
                translation.de = $0.translations?.de
                translation.es = $0.translations?.es
                translation.fa = $0.translations?.fa
                translation.fr = $0.translations?.fr
                translation.hr = $0.translations?.hr
                translation.it = $0.translations?.it
                translation.ja = $0.translations?.ja
                translation.nl = $0.translations?.nl
                translation.pt = $0.translations?.pt
                country.translation = translation
                
                if let regionalBlocs = $0.regionalBlocs {
                    let _ = regionalBlocs.map {
                        let regionalBloc = NSEntityDescription.insertNewObject(forEntityName: "FCRegionalBlocs", into: context!) as! FCRegionalBlocs
                        regionalBloc.acronym = $0.acronym
                        let reginonalBlocs = country.mutableOrderedSetValue(forKey: "reginonalBlocs")
                        reginonalBlocs.add(regionalBloc)
                    }
                }                
            }
        }
        do {
            try context?.save()
        } catch  {
            print("Error::: Country is not saved in DB")
        }
    }
    
    func save(country: FCCountryModel?) {
        if let countryInfo = country {
            
            let country = NSEntityDescription.insertNewObject(forEntityName: "FCCountry", into: context!) as! FCCountry
            
            country.name = countryInfo.name
            country.capital = countryInfo.capital
            country.region = countryInfo.region
            country.subRegion = countryInfo.subregion
            country.callingCodes = countryInfo.callingCodes            
            if let population = countryInfo.population {
                country.population = Int64(population)
            }
            if let area = countryInfo.area {
                country.area = Int64(area)
            }
            country.nativeName = countryInfo.nativeName
            country.flag = countryInfo.flag
            country.altSpellings = countryInfo.altSpellings
            country.timezones = countryInfo.timezones
            country.borders = countryInfo.borders
            
            if let currencies = countryInfo.currencies {
                let _ = currencies.map {
                    let currency = NSEntityDescription.insertNewObject(forEntityName: "FCCurrencies", into: context!) as! FCCurrencies
                    currency.code = $0.code
                    currency.name = $0.name
                    currency.symbol = $0.symbol
                    let currencies = country.mutableOrderedSetValue(forKey: "currencies")
                    currencies.add(currency)
                }
            }
            
            if let languages = countryInfo.languages {
                let _ = languages.map {
                    let language = NSEntityDescription.insertNewObject(forEntityName: "FCLanguages", into: context!) as! FCLanguages
                    language.name = $0.name
                    language.nativeName = $0.nativeName
                    let languages = country.mutableOrderedSetValue(forKey: "languages")
                    languages.add(language)
                }
            }
            
            let translation = NSEntityDescription.insertNewObject(forEntityName: "FCTranslations", into: context!) as! FCTranslations
            translation.br = countryInfo.translations?.br
            translation.de = countryInfo.translations?.de
            translation.es = countryInfo.translations?.es
            translation.fa = countryInfo.translations?.fa
            translation.fr = countryInfo.translations?.fr
            translation.hr = countryInfo.translations?.hr
            translation.it = countryInfo.translations?.it
            translation.ja = countryInfo.translations?.ja
            translation.nl = countryInfo.translations?.nl
            translation.pt = countryInfo.translations?.pt
            country.translation = translation
            
            if let regionalBlocs = countryInfo.regionalBlocs {
                let _ = regionalBlocs.map {
                    let regionalBloc = NSEntityDescription.insertNewObject(forEntityName: "FCRegionalBlocs", into: context!) as! FCRegionalBlocs
                    regionalBloc.acronym = $0.acronym
                    let reginonalBlocs = country.mutableOrderedSetValue(forKey: "reginonalBlocs")
                    reginonalBlocs.add(regionalBloc)
                }
            }
        }
        do {
            try context?.save()
        } catch  {
            print("Error::: Country is not saved in DB")
        }
    }
    
    
    func searchCountry(searchText: String) -> [FCCountry] {
        print("searchCountry :: %@", searchText)
        var countryArray = [FCCountry]()
        // Initialize Fetch Request
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>()
        
        // Create Entity Description
        let entityDescription = NSEntityDescription.entity(forEntityName: "FCCountry", in: context!)
        
        // Configure Fetch Request
        fetchRequest.entity = entityDescription
        
        // Add Sort Descriptor
        let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        // Add Predicate
        let predicate = NSPredicate(format: "name CONTAINS[c] %@", searchText)
        if searchText.count > 0 {
            fetchRequest.predicate = predicate
        }
        do {
            countryArray = try context?.fetch(fetchRequest) as! [FCCountry]
        } catch {
            print(error)
        }
        return countryArray
    }
    
    func isExist(searchText: String) -> Bool {
        var countryArray = [FCCountry]()
        // Initialize Fetch Request
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>()
        
        // Create Entity Description
        let entityDescription = NSEntityDescription.entity(forEntityName: "FCCountry", in: context!)
        
        // Configure Fetch Request
        fetchRequest.entity = entityDescription
        
        // Add Sort Descriptor
        let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        // Add Predicate
        let predicate = NSPredicate(format: "name = %@", searchText)
        fetchRequest.predicate = predicate
        do {
            countryArray = try context?.fetch(fetchRequest) as! [FCCountry]
            if countryArray.count > 0 {
                return true
            }
        } catch {
            print(error)
            return false
        }
        return false
    }
    
}

