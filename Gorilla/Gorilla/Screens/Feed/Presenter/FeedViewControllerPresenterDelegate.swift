//
//  FeedViewControllerPresenterDelegate.swift
//  Gorilla
//
//  Created by Galushka on 3/13/19.
//  Copyright © 2019 Galushka.com. All rights reserved.
//

import Foundation

protocol FeedViewControllerPresenterOutput: AnyObject {
    func displaySearchResults(_ searchResults: [FeedCollectionImageViewCellViewModel])
}
