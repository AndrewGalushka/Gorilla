//
//  ImgurSearchServiceType.swift
//  Gorilla
//
//  Created by Galushka on 3/21/19.
//  Copyright © 2019 Galushka.com. All rights reserved.
//

import Foundation
import Moya

protocol ImgurGallerySearchServiceType {
    func search(by params: ImgurAPI.Gallery.Search.Params, competion: @escaping (_ result: SpecificResult<ImgureGallerySearchResult, MoyaError>) -> Void)
}
