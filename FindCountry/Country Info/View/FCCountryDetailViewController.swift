//
//  FCCountryDetailViewController.swift
//  FindCountry
//
//  Created by eCOM-shabi.naqvi on 16/12/18.
//  Copyright © 2018 shabi. All rights reserved.
//

import Foundation
import UIKit

enum CountryInfoType: Int {
    case translation = 0
    case languages
    case borders
    case altSpellings
    case regionalBlocs
}

class FCCountryDetailViewController: UIViewController {
    
    var countryDetail: FCCountryModel?
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var currencyNameLabel: UILabel!
    @IBOutlet weak var currencySymbolLabel: UILabel!
    @IBOutlet weak var capitalLabel: UILabel!
    @IBOutlet weak var areaLabel: UILabel!
    @IBOutlet weak var populationLabel: UILabel!
    @IBOutlet weak var regionLabel: UILabel!
    @IBOutlet weak var subRegionLabel: UILabel!
    @IBOutlet weak var flagSVGView: UIView!
    
    @IBOutlet weak var countryDetailCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear( _ animated: Bool) {
        super.viewWillAppear(animated)
        setupUI()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func setupUI() {
        self.navigationItem.title = self.countryDetail?.name
        
        self.countryDetailCollectionView.register(FCTranslationCell.self, forCellWithReuseIdentifier: "FCTranslationCell")
        self.countryDetailCollectionView.register(FCSubdetailCell.self, forCellWithReuseIdentifier: "FCSubdetailCell")
        self.countryDetailCollectionView.register(
            UINib(nibName: "FCCountryDetailHeaderView", bundle: nil),
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: "FCCountryDetailHeaderView"
        )
    
        if let headerInfo = self.countryDetail {
            self.configureHeader(countryDetail: headerInfo)
        }
    }
    
    func configureHeader(countryDetail: FCCountryModel) {
        
        self.nameLabel.text = countryDetail.name
        self.currencyNameLabel.text = countryDetail.currencies?.first?.code
        self.currencySymbolLabel.text = countryDetail.currencies?.first?.symbol
        self.capitalLabel.text = countryDetail.capital
        if let area = countryDetail.area {
            self.areaLabel.text = String(describing: area)
        }
        if let population = countryDetail.population {
            self.populationLabel.text = String(describing: population)
        }
        self.regionLabel.text = countryDetail.region
        self.subRegionLabel.text = countryDetail.subregion
        
        if let flagUrl = countryDetail.flag, let svgURL = URL(string: flagUrl) {
            _ = UIView(SVGURL: svgURL) { (svgLayer) in
                svgLayer.resizeToFit(self.flagSVGView.bounds)
                self.flagSVGView.layer.addSublayer(svgLayer)
            }
        }
    }
    
    @IBAction func saveCountryDetail(_ sender: UIButton) {
        if FCDatabaseHelper.shared.isExist(searchText: self.countryDetail?.name ?? "") {
            FCUtility.showAlert(title: "Saved", message: "This Country is Already Saved!!", actionTitles: "Ok", actions: nil)
            return
        }
        FCDatabaseHelper.shared.save(country: self.countryDetail)
    }
}

extension FCCountryDetailViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.row == 0 {
            let cell = (collectionView.dequeueReusableCell(
                withReuseIdentifier: "FCTranslationCell",
                for: indexPath) as? FCTranslationCell)!
            cell.countryDetail = self.countryDetail
            return cell
        }
        let cell = (collectionView.dequeueReusableCell(
            withReuseIdentifier: "FCSubdetailCell",
            for: indexPath) as? FCSubdetailCell)!
        cell.countryDetail = self.countryDetail
        return cell
    }
}


// MARK: - UICollectionViewDelegateFlowLayout
extension FCCountryDetailViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width*1/2 - 10  , height: collectionView.bounds.height - 10)
    }
}
