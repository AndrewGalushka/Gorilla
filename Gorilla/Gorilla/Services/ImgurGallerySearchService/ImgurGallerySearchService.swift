//
//  ImgurSearchService.swift
//  Gorilla
//
//  Created by Galushka on 3/21/19.
//  Copyright © 2019 Galushka.com. All rights reserved.
//

import Foundation
import Moya

class ImgurGallerySearchService: ImgurGallerySearchServiceType {
    
    // MARK: - Properties(Private)
    
    private var imgurRequestManager: ImgurRequestManager
    
    // MARK: - Initializers
    
    init(imgurRequestManager: ImgurRequestManager) {
        self.imgurRequestManager = imgurRequestManager
    }
    
    // MARK: - Methods(Public)
    
    func search(by params: ImgurAPI.Gallery.Search.Params, competion: @escaping (_ result: SpecificResult<ImgureGallerySearchResult, MoyaError>) -> Void) {
        let gallerySearchAPI: ImgurAPI = ImgurAPI.gallery(.search(params))
        let responseDataMapper = SimpleJSONDataMapper<ImgureGallerySearchResult>()
        
        imgurRequestManager.execute(gallerySearchAPI, mapper: responseDataMapper) { (response) in
            
            DispatchQueue.main.async {
                switch response {
                case .success(let gallerySearchResult):
                    competion(.success(gallerySearchResult))
                case .failure(let error):
                    competion(.failure(error))
                }
            }
        }
    }
}
