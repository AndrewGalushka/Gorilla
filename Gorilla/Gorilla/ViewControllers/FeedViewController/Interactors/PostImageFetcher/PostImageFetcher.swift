//
//  PostImageDownloader.swift
//  Gorilla
//
//  Created by Galushka on 3/15/19.
//  Copyright © 2019 Galushka.com. All rights reserved.
//

import Kingfisher

enum PostImageFetcherError: Error {
    case badURL
    case other(Error)
}

class PostImageFetcher {
    
    // MARK: - Properties(Public)
    
    var maxParallelFetching: Int {
        get {
            return operationQueue.maxConcurrentOperationCount
        }
        
        set {
            operationQueue.maxConcurrentOperationCount = newValue
        }
    }
    
    // MARK: - Properties(Private)
    
    private let operationQueue: OperationQueue
    private let operationMaxLockTime: Double = 10.0
    
    // MARK: - Initializers
    
    init(maxParallelFetching: Int = 5) {
        let operationQueue = OperationQueue()
        operationQueue.name = "com.gorilla.post.image.fetcher.queue"
        operationQueue.maxConcurrentOperationCount = maxParallelFetching
        
        self.operationQueue = operationQueue
    }
    
    // MARK: - Methods(Public)
    
    func fetch(_ postImage: ImgureGallerySearchResult.Post.Image, completion: @escaping (_ result: SpecificResult<UIImage, PostImageFetcherError>) -> Void) {
        
        guard let URL = URL(string: postImage.link) else {
            completion(.failure(PostImageFetcherError.badURL))
            return
        }
        
        operationQueue.addOperation {
            
            let semaphore = DispatchSemaphore(value: 0)
            
            KingfisherManager.shared.downloader.downloadImage(with: URL, options: nil) { (response) in
                let result: SpecificResult<UIImage, PostImageFetcherError>
                
                switch response {
                case .success(let imageDowloadingResult):
                    result = .success(imageDowloadingResult.image)
                case .failure(let error):
                    result = .failure(.other(error))
                }
                
                DispatchQueue.main.async {
                    completion(result)
                }
            }
            
            let waitingResult = semaphore.wait(timeout: .now() + self.operationMaxLockTime)
            
            switch waitingResult {
            case .success: break
            case .timedOut:
                print("PostImageFetcher waiting TIMEOUT|time=\(self.operationMaxLockTime)")
            }
        }
    }
}
