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
    
    private typealias SearchedResult = (identifier: String, imageURL: URL)
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
        collectionView.setCollectionViewLayout(self.bigLayout, animated: false)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(FeedCollectionImageViewCell.nib, forCellWithReuseIdentifier: FeedCollectionImageViewCell.reuseIdentifier)
    }
    
    enum CollectionViewLayoutType {
        case small
        case mid
        case big
    }
    
    var currentLayoutType: CollectionViewLayoutType = .big
    
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

    func presentErrorAlert(error: Error) {

        var presentingViewController: UIViewController

        if let presentedVC = presentedViewController {
            presentingViewController = presentedVC
        } else {
            presentingViewController = self
        }

        let alertController = UIAlertController(title: nil, message: error.localizedDescription, preferredStyle:
        .alert)
        alertController.addAction( UIAlertAction(title: "OK", style: .cancel))
        presentingViewController.present(alertController, animated: true)}
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
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        self.searchController?.searchBar.resignFirstResponder()
    }
}

extension FeedViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        if let searchBarText = searchBar.text, !searchBarText.isEmpty {
            let gallerySearchAPI: ImgurAPI = ImgurAPI.gallery(.search(.init(query: searchBarText, size: .small, type: .png)))
            
            ImgurRequestManager.shared.execute(gallerySearchAPI, mapper: SimpleJSONDataMapper<ImgureGallerySearchResult>()) { (result) in
                
                switch result {
                case .success(let gallerySearchResult):
                    self.updateViewModels(gallerySearchResult: gallerySearchResult)
                case .failure(let error):
                    print(error)
                    self.clearTableView()
                }
            }
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
//            let images = post.images
            
            for image in images {
            
                switch image.type {
                case .imageJPEG, .imagePNG:
                    
                    if let imageURL = URL(string: image.link)  {
                        viewModels.append(FeedCollectionImageViewCellViewModel(identifier: image.identifier))
                        searchedResults.append(SearchedResult(image.identifier, imageURL))
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
