//
//  FeedViewController.swift
//  Gorilla
//
//  Created by Galushka on 2019-02-18.
//  Copyright © 2019 Galushka.com. All rights reserved.
//

import UIKit
import Alamofire
import Moya
import Kingfisher

class FeedViewController: UIViewController {
    @IBOutlet private weak var collectionView: UICollectionView!
    private var searchController: UISearchController?
    
    var viewModels = [FeedCollectionImageViewCellViewModel]()
    
    private typealias SearchedResult = (identifier: String, imageURL: URL, imageHeight: Int?, imageWidth: Int?)
    private var searchedResults = [SearchedResult]()
    
    private var imageDownloadingDispatchQueue: OperationQueue {
        let dispatchQueue = OperationQueue()
        dispatchQueue.maxConcurrentOperationCount = 5
        
        return dispatchQueue
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        configureSearchItem()
        configureNavigationView()
        configureCollectionView()
    }

    private func configureSearchItem() {
        searchController = UISearchController(searchResultsController: nil)
        self.definesPresentationContext = true
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
        collectionView.setCollectionViewLayout(self.plainLayout, animated: false)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(FeedCollectionImageViewCell.nib, forCellWithReuseIdentifier: FeedCollectionImageViewCell.reuseIdentifier)
    }
    
    enum CollectionViewLayoutType {
        case plain
        case grid
    }
    
    var currentLayoutType: CollectionViewLayoutType = .plain
    
    var plainLayout: UICollectionViewFlowLayout {
        let collectionViewLayout = UICollectionViewFlowLayout()
        collectionViewLayout.minimumInteritemSpacing = 0.0
        collectionViewLayout.minimumLineSpacing = 0.0
        collectionViewLayout.itemSize = CGSize(width: self.collectionView.bounds.width, height: self.collectionView.bounds.width)
        
        return collectionViewLayout
    }
    
    var gridLayout: UICollectionViewFlowLayout {
        let collectionViewLayout = UICollectionViewFlowLayout()
        collectionViewLayout.minimumInteritemSpacing = 0.0
        collectionViewLayout.minimumLineSpacing = 0.0
        collectionViewLayout.itemSize = CGSize(width: self.collectionView.bounds.width / 2.0, height: self.collectionView.bounds.width / 2.0)
        
        return collectionViewLayout
    }
}

extension FeedViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FeedCollectionImageViewCell.reuseIdentifier, for: indexPath) as! FeedCollectionImageViewCell
        cell.configure(viewModel: viewModels[indexPath.row])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        if let cell = cell as? FeedCollectionImageViewCell, let cellViewModel = cell.viewModel, let relatedSearchedVM = searchedResults.first(where: { $0.identifier == cellViewModel.identifier}) {
            
            self.imageDownloadingDispatchQueue.addOperation {
                
                let semaphore = DispatchSemaphore(value: 0)
                
                KingfisherManager.shared.downloader.downloadImage(with: relatedSearchedVM.imageURL) { result in
                    
                    switch result {
                    case .success(let imageLoadingResult):
                        cellViewModel.imageURL.value = imageLoadingResult.image
                    case .failure(let error):
                        print("/n URL=\(relatedSearchedVM.imageURL) ERROR=\(error.localizedDescription)/n")
                    }
                    
                    semaphore.signal()
                }
                
               _ = semaphore.wait(timeout: DispatchTime.now() + 10.0)
            }
        }
    }
}

extension FeedViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        switch self.currentLayoutType {
        case .plain:
            self.collectionView.setCollectionViewLayout(self.gridLayout, animated: true)
            self.currentLayoutType = .grid
        case .grid:
            self.collectionView.setCollectionViewLayout(self.plainLayout, animated: true)
            self.currentLayoutType = .plain
        }
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        self.searchController?.searchBar.resignFirstResponder()
    }
}

extension FeedViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let model = searchedResults[indexPath.row]
        
        var size = CGSize()
        size.width = collectionView.bounds.width
        
        if let width = model.imageHeight, let height = model.imageWidth {
            let cgWidth = CGFloat(width) / UIScreen.main.scale
            let cgHeight = CGFloat(height) / UIScreen.main.scale
            
            let finalWidth: CGFloat
            
            switch self.currentLayoutType {
            case .plain:
                finalWidth = collectionView.bounds.width
            case .grid:
                finalWidth = collectionView.bounds.width / 2.0
            }
            
            let finalHeight = CGSize(width: cgWidth, height: cgHeight).heightToAspectFit(inWidth: finalWidth)
            size = CGSize(width: finalWidth, height: finalHeight)
        } else {
            size.height = collectionView.bounds.width
        }
        
        print("sizeForItemAt \(indexPath) --- \(size)")
        return size
    }
}

extension FeedViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        if let searchBarText = searchBar.text, !searchBarText.isEmpty {
            let gallerySearchAPI: ImgurAPI = ImgurAPI.gallery(.search(.init(query: searchBarText, size: .small, type: .png)))
            
//            ImgurRequestManager.shared.execute(gallerySearchAPI, mapper: SimpleJSONDataMapper<ImgureGallerySearchResult>()) { (result) in
//
//                switch result {
//                case .success(let gallerySearchResult):
//                    self.updateViewModels(gallerySearchResult: gallerySearchResult)
//                case .failure(let error):
//                    print(error)
//                    self.clearTableView()
//                }
//            }
        }
    }
    
    func clearTableView() {
        self.viewModels.removeAll()
        self.searchedResults.removeAll()
        self.collectionView.reloadData()
    }
    
    func updateViewModels(gallerySearchResult: ImgureGallerySearchResult?) {
        
        guard let gallerySearchResult = gallerySearchResult else {
            clearTableView()
            return
        }
    
        var viewModels = [FeedCollectionImageViewCellViewModel]()
        var searchedResults = [SearchedResult]()

        for post in gallerySearchResult.posts {
            
            guard let images = post.images else { continue }
            
            for image in images {
            
                switch image.type {
                case .imageJPEG, .imagePNG:
                    
                    if let imageURL = URL(string: image.link)  {
                        viewModels.append(FeedCollectionImageViewCellViewModel(identifier: image.identifier))
                        searchedResults.append(SearchedResult(image.identifier, imageURL, image.height, image.width))
                    }
                case .unknown, .imageGIF, .videoMP4:
                    print("UNSUPPORTED CONTENT TYPE - \(image.type.rawValue)")
                    break
                }
            }
        }
        
        self.viewModels = viewModels
        self.searchedResults = searchedResults
        collectionView.reloadData()
    }
}
