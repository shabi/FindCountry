//
//  FCCountryListCell.swift
//  FindCountry
//
//  Created by eCOM-shabi.naqvi on 14/12/18.
//  Copyright © 2018 shabi. All rights reserved.
//

import UIKit
import SwiftSVG

class FCCountryListCell: UICollectionViewCell {
    
    @IBOutlet weak var flagSVGView: UIView!
    @IBOutlet weak var countryName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    //Function to excuted code in background
    //i.e will be used to load images
    func BG(_ block: @escaping ()->Void) {
        DispatchQueue.global(qos: .default).async(execute: block)
    }
    
    //Function to excuted code in foreground
    //Once loading get completes it will render on main thread here
    func UI(_ block: @escaping ()->Void) {
        DispatchQueue.main.async(execute: block)
    }
    
    func configureCountryList(countryInfo: FCCountryModel?) {
        if let country = countryInfo {
            self.countryName.text = country.name
            
            self.BG {
                if let flagUrl = country.flag, let svgURL = URL(string: flagUrl) {
                    _ = UIView(SVGURL: svgURL) { (svgLayer) in
                        self.UI {
                            let _ = self.flagSVGView.layer.sublayers?.popLast()
                            svgLayer.resizeToFit(self.flagSVGView.bounds)
                            self.flagSVGView.contentMode = .scaleToFill
                            self.flagSVGView.layer.addSublayer(svgLayer)
                        }
                    }
                }
            }
        }
    }
}
