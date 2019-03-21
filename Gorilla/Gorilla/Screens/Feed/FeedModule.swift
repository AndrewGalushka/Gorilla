//
//  FeedModule.swift
//  Gorilla
//
//  Created by Galushka on 3/13/19.
//  Copyright © 2019 Galushka.com. All rights reserved.
//

import UIKit

class FeedModule {
    private let feedViewController: FeedViewController
    private let presenter: FeedViewControllerPresenter
    private let searchInteractor: ImgurGallerySearchInteractor
    
    private init(serviceFactory: AppCoordinator.ServicesFactory) {
        searchInteractor = ImgurGallerySearchInteractor(gallerySearchService: serviceFactory.gallerySearchService)
        presenter = FeedViewControllerPresenter()
        feedViewController = FeedViewController.instantiateFromStoryboard()
        
        presenter.searchInteractor = searchInteractor
        presenter.view = feedViewController
        feedViewController.delegate = presenter
    }
    
    static func buildModule(serviceFactory: AppCoordinator.ServicesFactory) -> FeedModule {
        let module = FeedModule(serviceFactory: serviceFactory)
        return module
    }
}

extension FeedModule: ScreenModule {
    
    var ownedViewController: UIViewController {
        return feedViewController
    }
}
