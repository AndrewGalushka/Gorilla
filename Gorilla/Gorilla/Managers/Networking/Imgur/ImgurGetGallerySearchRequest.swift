//
// Created by Galushka on 2019-02-21.
// Copyright (c) 2019 Galushka.com. All rights reserved.
//

import Foundation
import Alamofire

class ImgurGetGallerySearchEndPoint: ImgurEndPoint {
    var httpMethod: HTTPMethod = .get
    
    var path: String {
        return "/3/gallery/search"
    }
    
    var queryItems: [URLQueryItem]? {
        var queryItems = [URLQueryItem]()
        queryItems.append(URLQueryItem(name: "q", value: query))
        
        if let mediaContentType = mediaContentType {
            queryItems.append(URLQueryItem(name: "q_type", value: mediaContentType.rawValue))
        }
        
        if let size = size {
            queryItems.append(URLQueryItem(name: "q_size_px", value: size.rawValue) )
        }
        
        return queryItems
    }
    
    var query = ""
    var mediaContentType: MediaConentType? = nil
    var size: SizeType? = nil
}

extension ImgurGetGallerySearchEndPoint {
    
    enum SizeType: String {
        case small = "small"
        case medium = "med"
        case big = "big"
        case large = "lrg"
        case huge = "huge"
    }
    
    enum SortType: String {
        case time
        case viral
        case top
    }
    
    enum MediaConentType: String {
        case jpg
        case png
        case gif
        case anigif
        case album
    }
}

