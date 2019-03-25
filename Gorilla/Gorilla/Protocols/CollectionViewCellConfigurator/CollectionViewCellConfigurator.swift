//
//  CollectionViewCellConfigurator.swift
//  Gorilla
//
//  Created by Galushka on 3/25/19.
//  Copyright © 2019 Galushka.com. All rights reserved.
//

import UIKit

protocol CollectionViewCellConfiguratorType {
    associatedtype Item
    associatedtype Cell: UICollectionViewCell
    
    func reuseIdentifier(for item: Item, indexPath: IndexPath) -> String
    func configure(cell: Cell, item: Item, collectionView: UICollectionView, indexPath: IndexPath) -> Cell
    func registerCells(in collectionView: UICollectionView)
}

extension CollectionViewCellConfiguratorType {
    
    func configuredCell(for item: Item, collectionView: UICollectionView, indexPath: IndexPath) -> Cell {
        let reuseIdentifier = self.reuseIdentifier(for: item, indexPath: indexPath)
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! Cell
        
        return self.configure(cell: cell, item: item, collectionView: collectionView, indexPath: indexPath)
    }
}

struct CollectionViewCellConfigurator<Item, Cell: UICollectionViewCell>: CollectionViewCellConfiguratorType {
    typealias CellConfigurator = (Cell,Item, UICollectionView, IndexPath) -> Cell
    
    let reuseIdentifier: String = "\(Cell.self)"
    let configurator: CellConfigurator
    
    func reuseIdentifier(for item: Item, indexPath: IndexPath) -> String {
        return reuseIdentifier
    }
    
    func configure(cell: Cell, item: Item, collectionView: UICollectionView, indexPath: IndexPath) -> Cell {
        return configurator(cell, item, collectionView, indexPath)
    }
    
    func registerCells(in collectionView: UICollectionView) {
        
        if let path = Bundle.main.path(forResource: "\(Cell.self)", ofType: "nib"),
            FileManager.default.fileExists(atPath: path) {
            let nib = UINib(nibName: "\(Cell.self)", bundle: .main)
            collectionView.register(nib, forCellWithReuseIdentifier: reuseIdentifier)
        } else {
            collectionView.register(Cell.self, forCellWithReuseIdentifier: reuseIdentifier)
        }
    }
}
