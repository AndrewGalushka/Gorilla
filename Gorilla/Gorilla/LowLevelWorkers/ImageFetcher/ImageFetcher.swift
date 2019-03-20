//
//  ImageFetcher.swift
//  Gorilla
//
//  Created by Galushka on 3/20/19.
//  Copyright © 2019 Galushka.com. All rights reserved.
//

import UIKit
import Kingfisher

enum ImageFetcherError: Error {
    case badURL
    case other(Error)
}

class ImageFetcher {

    // MARK: - Methods(Public)
    
    func fetch(_ urlString: String, completion: @escaping (_ result: SpecificResult<UIImage, ImageFetcherError>) -> Void) {
        
        guard let url = URL(string: urlString) else {
            completion(.failure(ImageFetcherError.badURL))
            return
        }
        
        self.fetch(url, completion: completion)
    }
    
    func fetch(_ url: URL, completion: @escaping (_ result: SpecificResult<UIImage, ImageFetcherError>) -> Void) {
        
        KingfisherManager.shared.retrieveImage(with: ImageResource(downloadURL: url), options: [.memoryCacheExpiration(.days(1))], completionHandler: { (response) in
            let result: SpecificResult<UIImage, ImageFetcherError>
            
            switch response {
            case .success(let imageDowloadingResult):
                result = .success(imageDowloadingResult.image)
            case .failure(let error):
                result = .failure(.other(error))
            }
            
            DispatchQueue.main.async {
                completion(result)
            }
        })
    }
}
