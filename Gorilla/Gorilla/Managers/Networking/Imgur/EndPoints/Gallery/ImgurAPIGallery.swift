//
// Created by Galushka on 2019-03-04.
// Copyright (c) 2019 Galushka.com. All rights reserved.
//

import Moya

extension ImgurAPI {
    
    enum Gallery {
        case search(Gallery.Search.Params)
    }
}

extension ImgurAPI.Gallery: ImgurTargetConvertible {
    var asImgurTarget: ImgurTarget {
        switch self {
        case .search(let params):
            return Search(params)
        }
    }
}


