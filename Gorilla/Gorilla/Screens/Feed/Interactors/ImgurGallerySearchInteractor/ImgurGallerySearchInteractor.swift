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
    
    private let imgurRequestManager: ImgurRequestManager
    
    // MARK: Initailizers
    
    init(imgurRequestManager: ImgurRequestManager) {
        self.imgurRequestManager = imgurRequestManager
    }
    
    // MARK: Methods(ImgurGallerySearchInteractorType)
    
    func search(by params: ImgurAPI.Gallery.Search.Params, competion: @escaping (_ result: SpecificResult<[ImgureGallerySearchResult.Post], MoyaError> ) -> Void) {
        
        let gallerySearchAPI: ImgurAPI = ImgurAPI.gallery(.search(params))
        
        imgurRequestManager.execute(gallerySearchAPI, mapper: SimpleJSONDataMapper<ImgureGallerySearchResult>()) { [weak self] (result) in
            
            DispatchQueue.main.async {
                guard let strongSelf = self else { return }
                
                switch result {
                case .success(let model):
                    strongSelf.lastSearchingResults = model.posts
                    competion(.success(model.posts))
                case .failure(let error):
                    strongSelf.lastSearchingResults.removeAll()
                    competion(.failure(error))
                }
            }
        }
    }
}
