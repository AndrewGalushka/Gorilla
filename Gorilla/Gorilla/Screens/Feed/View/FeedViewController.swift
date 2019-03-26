//
//  FeedViewController.swift
//  Gorilla
//
//  Created by Galushka on 2019-02-18.
//  Copyright © 2019 Galushka.com. All rights reserved.
//

import UIKit

class FeedViewController: UIViewController {
    
    // MARK: - Properties(Public)
    
    weak var delegate: FeedViewOutput?
    
    // MARK: - Properties(Public)
    
    @IBOutlet private weak var collectionView: UICollectionView!
    private var searchController: UISearchController?
    
    private var collectionDataSourceController: CollectionViewDataSourceController<FeedCollectionImageViewCellViewModel>!
    
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
        let imageViewCellConfigurator = CollectionViewCellConfigurator<FeedCollectionImageViewCellViewModel, FeedCollectionImageViewCell>.init { (cell, item, collectionView, indexPath) -> FeedCollectionImageViewCell in
            cell.configure(viewModel: item)
            
            return cell
        }
        
        let anyConfigurator = AnyCollectionViewCellConfigurator<FeedCollectionImageViewCellViewModel>(imageViewCellConfigurator)
        
        self.collectionDataSourceController = CollectionViewDataSourceController<FeedCollectionImageViewCellViewModel>(dataSource: .init(sections: [.init(items: [])]),
                                                                                                                       configurator: anyConfigurator)
        
        collectionView.setCollectionViewLayout(self.plainLayout, animated: false)
        collectionView.dataSource = collectionDataSourceController
        collectionView.delegate = self
        
        collectionDataSourceController.registerCells(in: collectionView)
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

extension FeedViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let item = self.collectionDataSourceController.dataSource.item(at: indexPath)
        self.delegate?.willDisplay(item)
    }
    
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
        
        let viewModel = self.collectionDataSourceController.dataSource.item(at: indexPath)
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
    
        self.collectionDataSourceController.dataSource.sections = [.init(items: searchResults)]
        self.collectionView.reloadData()
    }
}
