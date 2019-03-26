//
//  AnyCollectionViewCellConfigurator.swift
//  Gorilla
//
//  Created by Galushka on 3/26/19.
//  Copyright © 2019 Galushka.com. All rights reserved.
//

import UIKit

struct AnyCollectionViewCellConfigurator<Item>: CollectionViewCellConfiguratorType {
     typealias Cell = UICollectionViewCell
    
    func reuseIdentifier(for item: Item, indexPath: IndexPath) -> String {
        return self._reuseIdentifier(item, indexPath)
    }
    
    func configure(cell: UICollectionViewCell, item: Item, collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell {
        return self._configure(cell, item, collectionView, indexPath)
    }
    
    func registerCells(in collectionView: UICollectionView) {
        self._registerCells(collectionView)
    }
    
    private let _reuseIdentifier: (Item, IndexPath) -> String
    private let _configure: (Cell, Item, UICollectionView, IndexPath) -> Cell
    private let _registerCells: (UICollectionView) -> Void
    
    init<U: CollectionViewCellConfiguratorType>(_ configurator: U) where U.Item == Item {
        
        self._reuseIdentifier = { (item, indexPath) -> String in
            return configurator.reuseIdentifier(for: item, indexPath: indexPath)
        }
        
        self._configure = { (cell, item, collectionView, indexPath) -> Cell in
            return configurator.configuredCell(for: item, collectionView: collectionView, indexPath: indexPath)
        }
        
        self._registerCells = { (collectionView: UICollectionView) in
            configurator.registerCells(in: collectionView)
        }
    }
}
