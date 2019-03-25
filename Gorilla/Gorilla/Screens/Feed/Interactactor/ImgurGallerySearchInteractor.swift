//
//  ImgurGallerySearchInteractor.swift
//  Gorilla
//
//  Created by Galushka on 3/13/19.
//  Copyright © 2019 Galushka.com. All rights reserved.
//

import Foundation
import Moya

class ImgurGallerySearchInteractor: ImgurGallerySearchInteractorType {
    
    // MARK: Properties(ImgurGallerySearchInteractorType)
    
    private(set) var lastSearchingResults = [ImgureGallerySearchResult.Post]()
    
    // MARK: Properties(Private)
    
    private let gallerySearchService: ImgurGallerySearchServiceType
    
    // MARK: Initailizers
    
    init(gallerySearchService: ImgurGallerySearchServiceType) {
        self.gallerySearchService = gallerySearchService
    }
    
    // MARK: Methods(ImgurGallerySearchInteractorType)
    
    func search(by params: ImgurAPI.Gallery.Search.Params, competion: @escaping (_ result: SpecificResult<[ImgureGallerySearchResult.Post], MoyaError> ) -> Void) {

        self.gallerySearchService.search(by: params) { (response) in
            switch response {
            case .success(let gallerySearchResult):
                self.lastSearchingResults = gallerySearchResult.posts
                competion(.success(gallerySearchResult.posts))
            case .failure(let error):
                self.lastSearchingResults = []
                competion(.failure(error))
            }
        }
    }
}
