//
//  FeedCollectionViewPresentor.swift
//  Gorilla
//
//  Created by Galushka on 3/27/19.
//  Copyright © 2019 Galushka.com. All rights reserved.
//

import UIKit

class FeedCollectionViewPresentor: FeedCollectionViewPresentorInput {
    
    // MARK: Properties(Public)
    
    weak var output: FeedCollectionViewPresentorOutput?
    
    // MARK: Properties(Private)
    
    private lazy var dataSource: CollectionViewDataSource<CellViewModel> = self.makeDataSource()
    
    // MARK: Methods(Public)
    
    func attach(to: UICollectionView) {
    }
    
    // MARK: Methods(Private)
    
    private typealias CellViewModel = FeedCollectionImageViewCellViewModel
    
    private func makeDataSource() -> CollectionViewDataSource<CellViewModel> {
        let configurator = self.makeConfigurator()
        let dataSource = CollectionViewDataSource<CellViewModel>(dataSource: DataSource<CellViewModel>(),
                                                                 configurator: configurator)
        
        return dataSource
    }
    
    private func makeConfigurator() -> AnyCollectionViewCellConfigurator<CellViewModel> {
        
        let imageViewCellConfigurator = CollectionViewCellConfigurator<CellViewModel, FeedCollectionImageViewCell>.init { (cell, item, collectionView, indexPath) -> FeedCollectionImageViewCell in
            cell.configure(viewModel: item)
            return cell
        }
        
        let anyConfigurator = AnyCollectionViewCellConfigurator<CellViewModel>(imageViewCellConfigurator)
        
        return anyConfigurator
    }
}
