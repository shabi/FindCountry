//
//  FCCountryListViewController.swift
//  ShopOnGo
//
//  Created by eCOM-shabi.naqvi on 14/11/18.
//  Copyright © 2018 shabi. All rights reserved.
//

import Foundation
import UIKit

class FCCountryListViewController: UIViewController {
    
    var countryListViewModel: FCCountryListViewModel?
    @IBOutlet weak var searchBarView: UISearchBar!
    @IBOutlet weak var countryListCollectionView: UICollectionView!
    @IBOutlet weak var searchBarPosition: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.countryListViewModel = FCCountryListViewModel(viewController: self)
        self.countryListViewModel?.fetchEventInfo(serviceType: .getCountry, searchText: "")
    }
    
    override func viewWillAppear( _ animated: Bool) {
        super.viewWillAppear(animated)
        setupUI()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(notification: Notification) {
        guard let keyboardInfo = notification.userInfo else { return }
        if let keyboardFrame: NSValue = keyboardInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height + 10
            let contenInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardHeight, right: 0)
            self.countryListCollectionView.contentInset = contenInset
        }
    }
    
    @objc func keyboardWillHide(notification: Notification) {
        let contentInset = UIEdgeInsets.zero
        self.countryListCollectionView.contentInset = contentInset
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func setupUI() {
        
        if FCUtility.isIphoneX() {
            self.searchBarPosition.constant = 84
        } else {
            self.searchBarPosition.constant = 70
        }
        
        let nav = self.navigationController?.navigationBar
        nav?.barStyle = UIBarStyle.black
        nav?.tintColor = UIColor.white
        nav?.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.orange]
        self.navigationItem.title = "Find Countries"
        
        let itemPurchasedCellNib = UINib(nibName: "FCCountryListCell", bundle: nil)
        self.countryListCollectionView.register(
            itemPurchasedCellNib, forCellWithReuseIdentifier: "FCCountryListCell")
    }
}

extension FCCountryListViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.countryListViewModel?.countryModel?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = (collectionView.dequeueReusableCell(
            withReuseIdentifier: "FCCountryListCell",
            for: indexPath) as? FCCountryListCell)!
        cell.configureCountryList(countryInfo: countryListViewModel?.countryModel?[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let countryDetailViewController = storyboard.instantiateViewController(withIdentifier: "FCCountryDetailViewController") as! FCCountryDetailViewController
        countryDetailViewController.countryDetail = countryListViewModel?.countryModel?[indexPath.row]
        self.navigationController?.pushViewController(countryDetailViewController, animated: true)
    }
}


// MARK: - UICollectionViewDelegateFlowLayout
extension FCCountryListViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width  , height: 44)
    }
}

extension FCCountryListViewController: ViewController {
    
    func updateView() {
        self.countryListCollectionView.reloadData()
    }
}

extension FCCountryListViewController: UISearchBarDelegate {
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        print("searchBarTextDidBeginEditing")
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        print("searchBarCancelButtonClicked")
        self.searchBarView.endEditing(true)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print("searchBarSearchButtonClicked")
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        SKServiceManager.shared.cancelRequest()
        self.countryListViewModel?.fetchEventInfo(serviceType: .getCountry, searchText: searchBar.text)
        print("searchBar")
    }
}

