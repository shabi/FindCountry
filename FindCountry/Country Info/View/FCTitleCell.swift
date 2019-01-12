//
//  FCTitleCell.swift
//  FindCountry
//
//  Created by eCOM-shabi.naqvi on 17/12/18.
//  Copyright © 2018 shabi. All rights reserved.
//

import UIKit

class FCTitleCell: UICollectionViewCell {
    
    fileprivate static let font = UIFont.systemFont(ofSize: 16)
    
    var title: UILabel = {
        let titel = UILabel()
        titel.textAlignment = .left
        titel.numberOfLines = 0
        titel.textColor = .black
        titel.font = FCTitleCell.font
        return titel
    }()

    let separator: CALayer = {
        let layer = CALayer()
        layer.backgroundColor = UIColor(red: 200 / 255.0, green: 199 / 255.0, blue: 204 / 255.0, alpha: 1).cgColor
        return layer
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.title.translatesAutoresizingMaskIntoConstraints = false
        addSubview(title)
        contentView.layer.addSublayer(separator)
        self.title.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
        self.title.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 10).isActive = true
        self.title.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    static func textHeight(_ text: String, width: CGFloat) -> CGFloat {
        let constrainedSize = CGSize(width: width, height: 1000)
        let attributes = [ NSAttributedString.Key.font: font ]
        let options: NSStringDrawingOptions = [.usesFontLeading, .usesLineFragmentOrigin]
        let bounds = (text as NSString).boundingRect(with: constrainedSize, options: options, attributes: attributes, context: nil)
        return ceil(bounds.height)
    }
    
    func configure(titleInfo: String) {
        self.title.text = titleInfo
    }
}

class FCCountryDetailHeaderView: UICollectionReusableView {
    
    var headerTitle: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.lineBreakMode = .byWordWrapping
        label.textColor = .black
        label.minimumScaleFactor = 0.5
        return label
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .lightGray
        addSubview(self.headerTitle)
        self.headerTitle.translatesAutoresizingMaskIntoConstraints = false
        self.headerTitle.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
        self.headerTitle.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 10).isActive = true
        self.headerTitle.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureHeader(titleInfo: String) {
        self.headerTitle.text = titleInfo
    }
}
