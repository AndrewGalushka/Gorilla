//
//  FeedViewController.swift
//  Gorilla
//
//  Created by Galushka on 2019-02-18.
//  Copyright © 2019 Galushka.com. All rights reserved.
//

import UIKit
import Alamofire

class FeedViewController: UIViewController {
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(FeedCollectionImageViewCell.nib, forCellWithReuseIdentifier: FeedCollectionImageViewCell.reuseIdentifier)
    }

    enum CollectionViewLayoutType {
        case small
        case mid
        case big
    }
    
    var currentLayoutType: CollectionViewLayoutType = .small
    
    var smallLayout: UICollectionViewFlowLayout {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumInteritemSpacing = 1.0
        flowLayout.itemSize = CGSize(width: self.collectionView.bounds.width / 8.0, height: self.collectionView.bounds.width / 10.0)
        
        return flowLayout
    }
    
    var midLayout: UICollectionViewFlowLayout {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumInteritemSpacing = 1.0
        flowLayout.itemSize = CGSize(width: self.collectionView.bounds.width / 4.0, height: self.collectionView.bounds.width / 5.0)
        
        return flowLayout
    }
    
    var bigLayout: UICollectionViewFlowLayout {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumInteritemSpacing = 1.0
        flowLayout.itemSize = CGSize(width: self.collectionView.bounds.width, height: self.collectionView.bounds.width / 2.0)
        
        return flowLayout
    }
}

extension FeedViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 100
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FeedCollectionImageViewCell.reuseIdentifier, for: indexPath)
        cell.contentView.backgroundColor = UIColor.randomColor()
        
        return cell
    }
}

extension FeedViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        switch self.currentLayoutType {
        case .small:
            self.collectionView.setCollectionViewLayout(self.midLayout, animated: true)
            self.currentLayoutType = .mid
        case .mid:
            self.collectionView.setCollectionViewLayout(self.bigLayout, animated: true)
            self.currentLayoutType = .big
        case .big:
            self.collectionView.setCollectionViewLayout(self.smallLayout, animated: true)
            self.currentLayoutType = .small
        }
    }
}

extension FeedViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    }
}
