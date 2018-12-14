//
//  FCCountryListCell.swift
//  FindCountry
//
//  Created by eCOM-shabi.naqvi on 14/12/18.
//  Copyright © 2018 shabi. All rights reserved.
//

import UIKit

protocol FCCountryListCellDelegate: class {
    func itemCountChanged(itemPrice: Float)
}

class FCCountryListCell: UICollectionViewCell {
    
    @IBOutlet weak var itemImageView: UIImageView!
    
    @IBOutlet weak var itemName: UILabel!
    @IBOutlet weak var itemSalePrice: UILabel!
    @IBOutlet weak var itemCount: UILabel!
    @IBOutlet weak var itemSize: UILabel!
    var totalItemCount = 1
    var indexPath: IndexPath?
    
    weak var delegate: FCCountryListCellDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    @IBAction func itemCountChanged(_ sender: Any) {
    }
    
    
    func configureCountryList(countryInfo: FCCountryModel) {
        
        //        if let checkedUrl = URL(string: (itemDetails.thumbnailImage) ?? "") {
        //            self.itemImageView.contentMode = .scaleAspectFit
        //            downloadImage(url: checkedUrl)
        //        }
    }
    
    
    func getDataFromUrl(url: URL, completion: @escaping (_ data: Data?, _  response: URLResponse?, _ error: Error?) -> Void) {
        URLSession.shared.dataTask(with: url) {
            (data, response, error) in
            completion(data, response, error)
            }.resume()
    }
    
    func downloadImage(url: URL) {
        print("Download Started")
        getDataFromUrl(url: url) { (data, response, error)  in
            guard let data = data, error == nil else { return }
            print(response?.suggestedFilename ?? url.lastPathComponent)
            print("Download Finished")
            DispatchQueue.main.async() { () -> Void in
                self.itemImageView.image = UIImage(data: data)
            }
        }
    }
}


