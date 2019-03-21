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
    
    // MARK: - Properties(Public)
    
    weak var delegate: FeedViewOutput?
    
    // MARK: - Properties(Public)
    
    @IBOutlet private weak var collectionView: UICollectionView!
    private var searchController: UISearchController?
    
    private var viewModels = [FeedCollectionImageViewCellViewModel]()
    
    private var imageDownloadingDispatchQueue: OperationQueue {
        let dispatchQueue = OperationQueue()
        dispatchQueue.maxConcurrentOperationCount = 5
        
        return dispatchQueue
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        configureSearchItem()
        configureNavigationView()
        configureCollectionView()
    }

    // MARK: - Methods(Private)
    
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
    
    // MARK: - CollectionView Layout
    
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
        self.delegate?.willDisplay(viewModels[indexPath.row])
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
        guard let delegate = delegate else { return CGSize.zero }
        
        let viewModel = self.viewModels[indexPath.row]
        return delegate.itemSize(for: viewModel, in: collectionView, style: self.currentLayoutType)
    }
}

extension FeedViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.delegate?.feedView(self, didTapSearchText: searchBar.text)
    }
}

extension FeedViewController: FeedViewControllerPresenterOutput {
    
    func displaySearchResults(_ searchResults: [FeedCollectionImageViewCellViewModel]) {
        self.viewModels = searchResults
        self.collectionView.reloadData()
    }
}
