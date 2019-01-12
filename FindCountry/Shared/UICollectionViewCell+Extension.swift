//
//  UICollectionViewCell+Extension.swift
//  FindCountry
//
//  Created by eCOM-shabi.naqvi on 19/12/18.
//  Copyright © 2018 shabi. All rights reserved.
//

import Foundation
import UIKit

extension UICollectionViewCell {
    func setCornerRadiusAndShadow(radius: CGFloat, shadowOffset: CGFloat) {
        
        layer.cornerRadius = 6.0
        layer.borderWidth = 1.0
        layer.borderColor = UIColor.clear.cgColor
        layer.masksToBounds = true
        layer.shadowColor = UIColor.lightGray.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 2.0)
        layer.shadowRadius = 2.0
        layer.shadowOpacity = 1.0
        layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: contentView.layer.cornerRadius).cgPath
    }
}
