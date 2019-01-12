//
//  FCTranslationCell.swift
//  FindCountry
//
//  Created by eCOM-shabi.naqvi on 16/12/18.
//  Copyright © 2018 shabi. All rights reserved.
//

import UIKit

class FCTranslationCell: UICollectionViewCell {
    
    var countryDetail: FCCountryModel?
    let translationArray = ["de", "es", "fr", "ja", "it", "br", "pt", "nl", "hr", "fa"]
    var titleInfo: String?
    var translationValue: String? {
        didSet {
            if "de" == translationValue {
                self.titleInfo = countryDetail?.translations?.de
            } else if "es" == translationValue {
                self.titleInfo = countryDetail?.translations?.es
            } else if "fr" == translationValue {
                self.titleInfo = countryDetail?.translations?.fr
            } else if "ja" == translationValue {
                self.titleInfo = countryDetail?.translations?.ja
            } else if "it" == translationValue {
                self.titleInfo = countryDetail?.translations?.it
            } else if "br" == translationValue {
                self.titleInfo = countryDetail?.translations?.br
            } else if "pt" == translationValue {
                self.titleInfo = countryDetail?.translations?.pt
            } else if "nl" == translationValue {
                self.titleInfo = countryDetail?.translations?.nl
            } else if "hr" == translationValue {
                self.titleInfo = countryDetail?.translations?.hr
            } else if "fa" == translationValue {
                self.titleInfo = countryDetail?.translations?.fa
            }
        }
    }
    
    let translationListcollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 4
        layout.scrollDirection = .vertical
        let translationList = UICollectionView(frame: .zero, collectionViewLayout: layout)
        translationList.backgroundColor = UIColor(red: 245/255, green: 193/255, blue: 100/255, alpha: 1.0)
        return translationList
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        //Extension method implemented
        self.setCornerRadiusAndShadow(radius: 6.0, shadowOffset: 2.0)
        self.setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        self.translationListcollectionView.register(FCTitleCell.self, forCellWithReuseIdentifier: "FCTitleCell")
        self.translationListcollectionView.register(FCCountryDetailHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "FCCountryDetailHeaderView")
        
        addSubview(self.translationListcollectionView)
        self.translationListcollectionView.delegate = self
        self.translationListcollectionView.dataSource = self
        
        self.translationListcollectionView.translatesAutoresizingMaskIntoConstraints = false
        self.translationListcollectionView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        self.translationListcollectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        self.translationListcollectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        self.translationListcollectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
    }
}

extension FCTranslationCell: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FCTitleCell", for: indexPath) as! FCTitleCell
        self.translationValue = self.translationArray[indexPath.row]
        cell.configure(titleInfo: self.titleInfo ?? "")
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "FCCountryDetailHeaderView", for: indexPath) as! FCCountryDetailHeaderView
        headerView.configureHeader(titleInfo: "Translations")
        return headerView
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.translationArray.count
    }
}

extension FCTranslationCell: UICollectionViewDelegateFlowLayout {
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        self.translationValue = self.translationArray[indexPath.row]
        let height = FCTitleCell.textHeight(self.titleInfo ?? "", width: collectionView.bounds.width)
        return CGSize(width: collectionView.bounds.width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: 22)
    }
}
