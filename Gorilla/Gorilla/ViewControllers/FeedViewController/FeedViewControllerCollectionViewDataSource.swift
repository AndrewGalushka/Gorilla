//
//  FeedViewControllerCollectionViewDataSource.swift
//  Gorilla
//
//  Created by Galushka on 2/27/19.
//  Copyright © 2019 Galushka.com. All rights reserved.
//

import UIKit

extension FeedViewController {
    class CollectionViewDataSource: NSObject, UICollectionViewDataSource {
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            fatalError()
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            fatalError()
        }
    }
}
