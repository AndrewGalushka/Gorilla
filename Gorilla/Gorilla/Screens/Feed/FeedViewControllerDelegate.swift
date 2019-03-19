//
//  FeedViewControllerDelegate.swift
//  Gorilla
//
//  Created by Galushka on 3/13/19.
//  Copyright © 2019 Galushka.com. All rights reserved.
//

import UIKit

protocol FeedViewControllerDelegate: AnyObject {
    var feedCollectionViewImageViewCellViewModels: [FeedCollectionImageViewCellViewModel] { get }
    func feedViewController(_ feedViewController: FeedViewController, didTapSearchText: String?)
    func itemSize(for imageViewCellViewModel: FeedCollectionImageViewCellViewModel, in collectionView: UICollectionView, style: FeedViewController.CollectionViewLayoutType) -> CGSize
    func willDisplay(_ imageViewModel: FeedCollectionImageViewCellViewModel)
    func didEndDisplaying(_ imageViewModel: FeedCollectionImageViewCellViewModel)
}
