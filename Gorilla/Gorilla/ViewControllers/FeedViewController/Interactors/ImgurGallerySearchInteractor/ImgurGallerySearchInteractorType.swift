//
//  ImgurGallerySearchInteractorType.swift
//  Gorilla
//
//  Created by Galushka on 3/13/19.
//  Copyright © 2019 Galushka.com. All rights reserved.
//

import Foundation
import Moya

protocol ImgurGallerySearchInteractorType: AnyObject {
    var lastSearchingResults: [ImgureGallerySearchResult.Post] { get }
    
    func search(by params: ImgurAPI.Gallery.Search.Params, competion: @escaping (_ result: SpecificResult<[ImgureGallerySearchResult.Post], MoyaError> ) -> Void)
}
