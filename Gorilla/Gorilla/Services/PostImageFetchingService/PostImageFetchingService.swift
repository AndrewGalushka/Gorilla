//
//  PostImageDownloader.swift
//  Gorilla
//
//  Created by Galushka on 3/15/19.
//  Copyright © 2019 Galushka.com. All rights reserved.
//

import Kingfisher

class PostImageFetchingService {
    
    // MARK: - Properties(Public)
    
    var maxParallelFetching: Int {
        get { return operationQueue.maxConcurrentOperationCount }
        set { operationQueue.maxConcurrentOperationCount = newValue }
    }
    
    var maxLockTime: Double = 1.0
    
    // MARK: - Properties(Private)
    
    private let imageFetcher: ImageFetcher
    private let operationQueue: OperationQueue = {
        let operationQueue = OperationQueue()
        operationQueue.name = "com.gorilla.post.image.fetcher.queue"
        
        return operationQueue
    }()
    
    // MARK: - Initializers
    
    init(imageFetcher: ImageFetcher) {
        self.imageFetcher = imageFetcher
    }
    
    // MARK: - Methods(Public)
    
    func fetch(_ postImage: ImgureGallerySearchResult.Post.Image, completion: @escaping (SpecificResult<UIImage, ImageFetcherError>) -> Void) {
        self.imageFetcher.fetch(postImage.link, completion: completion)
    }
}
