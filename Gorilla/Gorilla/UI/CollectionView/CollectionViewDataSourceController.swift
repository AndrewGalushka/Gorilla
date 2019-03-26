//
//  CollectionViewController.swift
//  Gorilla
//
//  Created by Galushka on 3/25/19.
//  Copyright © 2019 Galushka.com. All rights reserved.
//

import UIKit

class CollectionViewDataSourceController<Item>: NSObject, UICollectionViewDataSource {
    var dataSource: DataSource<Item>
    var configurator: AnyCollectionViewCellConfigurator<Item>
    
    func registerCells(in colletionView: UICollectionView) {
        configurator.registerCells(in: colletionView)
    }
    
    init(dataSource: DataSource<Item>, configurator: AnyCollectionViewCellConfigurator<Item>) {
        self.dataSource = dataSource
        self.configurator = configurator
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.numberOfItems(in: section)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return dataSource.numberOfSections()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return configurator.configuredCell(for: dataSource.item(at: indexPath), collectionView: collectionView, indexPath: indexPath)
    }
}


