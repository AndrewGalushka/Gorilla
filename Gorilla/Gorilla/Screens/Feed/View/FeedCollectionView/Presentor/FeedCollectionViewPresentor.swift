//
//  FeedCollectionViewPresentor.swift
//  Gorilla
//
//  Created by Galushka on 3/27/19.
//  Copyright © 2019 Galushka.com. All rights reserved.
//

import UIKit

class FeedCollectionViewPresentor: FeedCollectionViewPresentorInput {
    
    private typealias CellViewModel = FeedCollectionImageViewCellViewModel
    
    // MARK: Methods(Private)
    
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
