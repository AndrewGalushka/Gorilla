//
//  FeedViewController.swift
//  Gorilla
//
//  Created by Galushka on 2019-02-18.
//  Copyright © 2019 Galushka.com. All rights reserved.
//

import UIKit
import Alamofire
import Kingfisher

class FeedViewController: UIViewController {
    @IBOutlet private weak var collectionView: UICollectionView!
    private var searchController: UISearchController?
    
    var viewModels = [FeedCollectionImageViewCellViewModel]()
    
    private typealias SearchedResult = (identifier: String, imageURL: URL)
    private var searchedResults = [SearchedResult]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        configureSearchItem()
        configureNavigationView()
        configureCollectionView()
    }

    private func configureSearchItem() {
        searchController = UISearchController(searchResultsController: nil)
        searchController?.definesPresentationContext = true
        searchController?.searchBar.delegate = self
        searchController?.searchBar.placeholder = "Search"
        searchController?.obscuresBackgroundDuringPresentation = false
        navigationItem.hidesSearchBarWhenScrolling = false
        self.navigationItem.searchController = searchController
    }
    
    private func configureNavigationView() {
        navigationItem.title = "Feed"
        navigationItem.largeTitleDisplayMode = .always
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func configureCollectionView() {
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
        return viewModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FeedCollectionImageViewCell.reuseIdentifier, for: indexPath) as! FeedCollectionImageViewCell
        cell.configure(viewModel: viewModels[indexPath.row])
        cell.contentView.backgroundColor = UIColor.randomColor()
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        if let cell = cell as? FeedCollectionImageViewCell, let cellViewModel = cell.viewModel, let relatedSearchedVM = searchedResults.first(where: { $0.identifier == cellViewModel.identifier}) {
            
            KingfisherManager.shared.downloader.downloadImage(with: relatedSearchedVM.imageURL) { result in
                
                switch result {
                case .success(let imageLoadingResult):
                    cellViewModel.imageURL.value = imageLoadingResult.image
                case .failure(let error):
                    print("/n URL=\(relatedSearchedVM.imageURL) ERROR=\(error.localizedDescription)/n")
                }
            }
        }
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
        
        if let searchBarText = searchBar.text, !searchBarText.isEmpty {
            let gallerySearchRequest = ImgurGetGallerySearchEndPoint()
            gallerySearchRequest.query = searchBarText
            gallerySearchRequest.mediaContentType = .jpg
            
            if let urlRequest = try? ImgurRequestBuilder(endPoint: gallerySearchRequest).asURLRequest() {
                
                Alamofire.request(urlRequest).responseJSON { (response) in
                    
                    switch response.result {
                    case .success(let json as [String: Any]):
                        self.updateViewModels(jsonDict: json)
                    case .success(_):
                        self.updateViewModels(jsonDict: nil)
                    case .failure(_):
                        self.updateViewModels(jsonDict: nil)
                    }
                }
            }
        } else {
            self.viewModels.removeAll()
            self.searchedResults.removeAll()
            self.collectionView.reloadData()
        }
    }
    
    func updateViewModels(jsonDict: [String: Any]?) {
        
        guard
            let jsonDict = jsonDict,
            let results = jsonDict["data"] as? [[String: Any]]
        else {
            self.viewModels.removeAll()
            self.searchedResults.removeAll()
            return
        }
        
        var viewModels = [FeedCollectionImageViewCellViewModel]()
        var searchedResults = [SearchedResult]()
        
        for result in results {

            guard let identifier = result["id"] as? String else { continue }
            
            if let images = result["images"] as? [[String: Any]],
                let firstImage = images.first,
                let imageUrlString = firstImage["link"] as? String,
                let imageUrl = URL(string: imageUrlString) {
                
                viewModels.append(FeedCollectionImageViewCellViewModel(identifier: identifier))
                searchedResults.append(SearchedResult(identifier, imageUrl))
            }
        }
        
        self.viewModels = viewModels
        self.searchedResults = searchedResults
        collectionView.reloadData()
    }
}
