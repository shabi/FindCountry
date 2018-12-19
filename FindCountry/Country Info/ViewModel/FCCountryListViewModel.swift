//
//  FCCountryListViewModel.swift
//  ShopOnGo
//
//  Created by eCOM-shabi.naqvi on 14/11/18.
//  Copyright © 2018 shabi. All rights reserved.
//

import Foundation
import SwiftyJSON

class FCCountryListViewModel {
    
    var countryListAPI: FCCountryListAPI?
    weak var viewController: ViewController?
    var countryModel: [FCCountryModel]?
    var countryArray: [FCCountry]?
    
    init(viewController: ViewController) {
        self.viewController = viewController
    }
    
    func fetchEventInfo(serviceType: APIConstants.ServiceType, searchText: String?) {
        if let search = searchText {
            
            SGProgressView.shared.showProgressView((self.viewController as! UIViewController).view)
            self.countryArray = FCDatabaseHelper.shared.searchCountry(searchText: search)
        
            if let countryArray = self.countryArray, countryArray.count > 0 {
                self.apiSuccess(serviceType: APIConstants.ServiceType.getCountry.rawValue, model: nil, isFromCache: true)
            } else {
                self.countryListAPI = FCCountryListAPI(serviceType: .getCountry, type: .fetchCountry, delegateViewModel: self, searchText: search)
                self.countryListAPI?.fetchData()
            }
        }
    }
}

extension FCCountryListViewModel: APIDelegateViewModel {
    
    func apiSuccess(serviceType: String, model: Any?, isFromCache: Bool) {
        
        if isFromCache {
            self.countryModel = self.mapCountryFromCacheToModel()
            DispatchQueue.main.async {
                self.viewController?.updateView()
            }
        } else if serviceType == APIConstants.ServiceType.getCountry.rawValue, let info = model as? FCCountriesFound, let countryArray = info.countryInfo {
            
            //Cache to DB
            FCDatabaseHelper.shared.save(countryInfo: countryArray)
            
            self.countryModel = countryArray
            DispatchQueue.main.async {
                self.viewController?.updateView()
            }
        }
        SGProgressView.shared.hideProgressView()
    }
    
    func apiFailure(serviceType: String, error: Error) {
        SGProgressView.shared.hideProgressView()
    }
    
    
    func mapCountryFromCacheToModel() -> [FCCountryModel] {
        var mapedCountryArray = [FCCountryModel]()
        if let countryArray = self.countryArray, countryArray.count > 0 {
            let updatedArray = countryArray.map { (eachCountry: FCCountry) -> FCCountryModel in
                
                let country = FCCountryModel.init(json: JSON())
                country.name = eachCountry.name
                country.capital = eachCountry.capital
                country.region = eachCountry.region
                country.population = Int(eachCountry.population)
                country.area = Int(eachCountry.area)
                

                country.nativeName = eachCountry.nativeName
                country.flag = eachCountry.flag
                country.altSpellings = eachCountry.altSpellings
                country.timezones = eachCountry.timezones
                country.borders = eachCountry.borders
                
                if let currencies = eachCountry.currencies?.array as? [FCCurrencies] {
                    let currencyArray = currencies.map { (currencyItem: FCCurrencies) -> Currencies in
                        let currency = Currencies.init(json: JSON())
                        currency.code = currencyItem.code
                        currency.name = currencyItem.name
                        currency.symbol = currencyItem.symbol
                        return currency
                    }
                    country.currencies = currencyArray
                }
                
                if let languages = eachCountry.languages?.array as? [FCLanguages] {
                    let languageArray = languages.map { (languageItem: FCLanguages) -> Languages in
                        let language = Languages.init(json: JSON())
                        language.name = languageItem.name
                        language.nativeName = languageItem.nativeName
                        return language
                    }
                    country.languages = languageArray
                }
                
                country.translations?.br = eachCountry.translation?.br
                country.translations?.de = eachCountry.translation?.de
                country.translations?.es = eachCountry.translation?.es
                country.translations?.fa = eachCountry.translation?.fa
                country.translations?.fr = eachCountry.translation?.fr
                country.translations?.hr = eachCountry.translation?.hr
                country.translations?.it = eachCountry.translation?.it
                country.translations?.ja = eachCountry.translation?.ja
                country.translations?.nl = eachCountry.translation?.nl
                country.translations?.pt = eachCountry.translation?.pt
                
                if let regionalBlocs = eachCountry.reginonalBlocs?.array as? [FCRegionalBlocs] {
                    let regionalBlocArray = regionalBlocs.map { (reginoalBlocItem: FCRegionalBlocs) -> RegionalBlocs in
                        let regionalBloc = RegionalBlocs.init(json: JSON())
                        regionalBloc.acronym = reginoalBlocItem.acronym
                        return regionalBloc
                    }
                    country.regionalBlocs = regionalBlocArray
                }
                
                return country
            }
            mapedCountryArray = updatedArray
        }
        return mapedCountryArray
    }
}
