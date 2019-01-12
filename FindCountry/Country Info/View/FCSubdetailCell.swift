//
//  FCSubdetailCell.swift
//  FindCountry
//
//  Created by eCOM-shabi.naqvi on 17/12/18.
//  Copyright © 2018 shabi. All rights reserved.
//

import UIKit

class FCSubdetailCell: UICollectionViewCell {
    
    var countryDetail: FCCountryModel?
    let subDetailCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 4
        layout.scrollDirection = .vertical
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor(red: 245/255, green: 227/255, blue: 204/255, alpha: 1.0)
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        //Extension method implemented
        self.setCornerRadiusAndShadow(radius: 6.0, shadowOffset: 2.0)
        self.setupUI()
        
    }
    
    func setupUI() {
        addSubview(self.subDetailCollectionView)
        self.subDetailCollectionView.delegate = self
        self.subDetailCollectionView.dataSource = self
        self.subDetailCollectionView.register(FCTitleCell.self, forCellWithReuseIdentifier: "FCTitleCell")
        self.subDetailCollectionView.register(FCCountryDetailHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "FCCountryDetailHeaderView")
        
        self.subDetailCollectionView.translatesAutoresizingMaskIntoConstraints = false
        self.subDetailCollectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        self.subDetailCollectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        self.subDetailCollectionView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        self.subDetailCollectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension FCSubdetailCell: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return self.countryDetail?.languages?.count ?? 0
        } else if section == 1 {
            return self.countryDetail?.borders?.count ?? 0
        } else if section == 2 {
            return self.countryDetail?.altSpellings?.count ?? 0
        } else if section == 3 {
            return self.countryDetail?.regionalBlocs?.count ?? 0
        } else if section == 4 {
            return self.countryDetail?.timezones?.count ?? 0
        } else if section == 5 {
            return self.countryDetail?.callingCodes?.count ?? 0
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FCTitleCell", for: indexPath) as! FCTitleCell
        if indexPath.section == 0 {
            cell.configure(titleInfo: self.countryDetail?.languages?[indexPath.row].nativeName ?? "")
        } else if indexPath.section == 1 {
            cell.configure(titleInfo: self.countryDetail?.borders?[indexPath.row] ?? "")
        } else if indexPath.section == 2 {
            cell.configure(titleInfo: self.countryDetail?.altSpellings?[indexPath.row] ?? "")
        } else if indexPath.section == 3 {
            cell.configure(titleInfo: self.countryDetail?.regionalBlocs?[indexPath.row].acronym ?? "")
        } else if indexPath.section == 4 {
            cell.configure(titleInfo: self.countryDetail?.timezones?[indexPath.row] ?? "")
        } else if indexPath.section == 5 {
            cell.configure(titleInfo: self.countryDetail?.callingCodes?[indexPath.row] ?? "")
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "FCCountryDetailHeaderView", for: indexPath) as! FCCountryDetailHeaderView
        if indexPath.section == 0 {
            headerView.configureHeader(titleInfo: "Languages")
        } else if indexPath.section == 1 {
            headerView.configureHeader(titleInfo: "Borders")
        } else if indexPath.section == 2 {
            headerView.configureHeader(titleInfo: "Alternate Spellings")
        } else if indexPath.section == 3 {
            headerView.configureHeader(titleInfo: "Regional Blocs")
        } else if indexPath.section == 4 {
            headerView.configureHeader(titleInfo: "TimeZones")
        } else if indexPath.section == 5 {
            headerView.configureHeader(titleInfo: "Calling Codes")
        }
        
        return headerView
    }
}

extension FCSubdetailCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var height: CGFloat = 0
        if indexPath.section == 0 {
            height = FCTitleCell.textHeight(self.countryDetail?.languages?[indexPath.row].nativeName ?? "", width: collectionView.bounds.width)
        } else if indexPath.section == 1 {
            height = FCTitleCell.textHeight(self.countryDetail?.borders?[indexPath.row] ?? "", width: collectionView.bounds.width)
        } else if indexPath.section == 2 {
            height = FCTitleCell.textHeight(self.countryDetail?.altSpellings?[indexPath.row] ?? "", width: collectionView.bounds.width)
        } else if indexPath.section == 3 {
            height = FCTitleCell.textHeight(self.countryDetail?.regionalBlocs?[indexPath.row].acronym ?? "", width: collectionView.bounds.width)
        } else if indexPath.section == 4 {
            height = FCTitleCell.textHeight(self.countryDetail?.timezones?[indexPath.row] ?? "", width: collectionView.bounds.width)
        } else if indexPath.section == 5 {
            height = FCTitleCell.textHeight(self.countryDetail?.callingCodes?[indexPath.row] ?? "", width: collectionView.bounds.width)
        }
        return CGSize(width: collectionView.bounds.width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if section == 1, let border = self.countryDetail?.borders, border.count == 0 {
            return .zero
        } else if section == 2, let altSpellings = self.countryDetail?.altSpellings, altSpellings.count == 0 {
            return .zero
        } else if section == 3, let regionalBlocs = self.countryDetail?.regionalBlocs, regionalBlocs.count == 0 {
            return .zero
        } else if section == 4, let timezones = self.countryDetail?.timezones, timezones.count == 0 {
            return .zero
        } else if section == 4, let timezones = self.countryDetail?.callingCodes, timezones.count == 0 {
            return .zero
        }
        
        return CGSize(width: collectionView.bounds.width, height: 22)
    }
}
