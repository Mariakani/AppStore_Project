//
//  appSearchViewController.swift
//  AppStore
//
//  Created by Mariak Achuoth on 2019-05-16.
//  Copyright © 2019 The Future I Dream. All rights reserved.
//

import UIKit
import SDWebImage

class appSearchViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout, UISearchResultsUpdating{
    
    

    fileprivate let cellId  = "alkaida211"
    fileprivate var appSearchResult = [Result]()
    
    let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.8275631421)
        collectionView.register(searchResultCell.self, forCellWithReuseIdentifier: cellId)
        fetchItuneApps()
        setUpSearchController()
    }
    
    fileprivate func fetchItuneApps()
    {
        
        
        //TODO- need to figure out to implement in this function
//        NetworkService.shared.fetchApps(searchTerm: "twitter") {(results) in
//            self.appSearchResult = results
//            DispatchQueue.main.async {
//
//             self.collectionView.reloadData()
//
//
//            }
//        }

    }
    
    fileprivate func  setUpSearchController()
    {
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "App Store"
        definesPresentationContext = true
    }
    
    
    //TODO--implement search bar
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text else {return}
        NetworkService.shared.fetchApps(searchTerm: searchText) { (results) in
            self.appSearchResult = results
            DispatchQueue.main.async {
                 self.collectionView.reloadData()
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return.init(width: view.frame.width, height: 350)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return appSearchResult.count
        
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! searchResultCell
        cell.layer.borderColor = UIColor.black.cgColor
        let appSearchReslt = appSearchResult[indexPath.item]
        cell.nameLabel.text = appSearchReslt.trackName
        cell.categoryLabel.text = appSearchReslt.primaryGenreName
        cell.ratingLabel.text = "Rating: \(appSearchReslt.averageUserRating ?? 0) M"
        let url = URL(string: appSearchReslt.artworkUrl100)
        cell.appIconImagView.sd_setImage(with: url)
        cell.screenshotImg1.sd_setImage(with: URL(string: appSearchReslt.screenshotUrls[0]))
        if appSearchReslt.screenshotUrls.count > 1{
            cell.screenshotImg2.sd_setImage(with: URL(string: appSearchReslt.screenshotUrls[1]))
            
        }
        
        if appSearchReslt.screenshotUrls.count > 2
        {
            cell.screenshotImg2.sd_setImage(with: URL(string: appSearchReslt.screenshotUrls[1]))
            cell.screenshotImg3.sd_setImage(with: URL(string: appSearchReslt.screenshotUrls[2]))
        }
          return cell
    }
    init(){
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

