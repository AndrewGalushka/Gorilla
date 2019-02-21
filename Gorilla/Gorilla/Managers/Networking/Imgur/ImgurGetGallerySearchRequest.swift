//
// Created by Galushka on 2019-02-21.
// Copyright (c) 2019 Galushka.com. All rights reserved.
//

import Foundation
import Alamofire

class ImgurGetGallerySearchRequest: ImgurEndPoint {
    var httpMethod: HTTPMethod = .get
    
    var path: String {
        return "gallery/search"
    }
    
    var queryItems: [URLQueryItem]? {
        return [URLQueryItem(name: "q", value: query)]
    }
    
    var query = ""
}

extension ImgurGetGallerySearchRequest {
    
    enum SortType: String {
        case time
        case viral
        case top
    }
}

