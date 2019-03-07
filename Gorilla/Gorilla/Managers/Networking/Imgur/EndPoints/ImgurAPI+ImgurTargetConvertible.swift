//
//  ImgurAPI+TargetConvertable.swift
//  Gorilla
//
//  Created by Galushka on 3/6/19.
//  Copyright © 2019 Galushka.com. All rights reserved.
//

import Foundation

extension ImgurAPI: ImgurTargetConvertible {
    var asImgurTarget: ImgurTarget{
        switch self {
        case .gallery(let galleryAPI):
            return galleryAPI.asImgurTarget
        }
    }
}
