//
//  FeedViewControllerPresenterModelsConvertor.swift
//  Gorilla
//
//  Created by Galushka on 3/14/19.
//  Copyright © 2019 Galushka.com. All rights reserved.
//

import Foundation

class FeedViewControllerPresenterModelsConvertor {
    
    func convert(searchResults: [ImgureGallerySearchResult.Post]) -> [FeedCollectionImageViewCellViewModel] {
        var viewModels = [FeedCollectionImageViewCellViewModel]()
        
        for post in searchResults {
            
            if let images = post.images, !images.isEmpty {
                let viewModel = FeedCollectionImageViewCellViewModel(identifier: post.identifier)
                viewModels.append(viewModel)
            }
        }
        
        return viewModels
    }
}
