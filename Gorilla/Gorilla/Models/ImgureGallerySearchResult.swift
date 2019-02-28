//
//  ImgureGallerySearchResult.swift
//  Gorilla
//
//  Created by Galushka on 2/26/19.
//  Copyright © 2019 Galushka.com. All rights reserved.
//

import Foundation

struct ImgureGallerySearchResult: Decodable {
    var posts: [Post]
    
    enum CodingKeys: String, CodingKey {
        case posts = "data"
    }
}

extension ImgureGallerySearchResult {

    struct Post: Decodable {
        var identifier: String
        var images: [Image]
        
        enum CodingKeys: String, CodingKey {
            case identifier = "id"
            case images = "images"
        }
    }
}

extension ImgureGallerySearchResult.Post {
    
    struct Image: Decodable {
        var identifier: String
        var link: String
        var type: ContentType
        var title: String?
        
        enum CodingKeys: String, CodingKey {
            case identifier = "id"
            case link = "link"
            case title = "title"
            case type = "type"
        }
    }
}

extension ImgureGallerySearchResult.Post.Image {
    
    enum ContentType: String, Decodable {
        case unknown = "unknown"
        case imageJPEG = "image/jpeg"
        case imagePNG = "image/png"
        case imageGIF = "image/gif"
        case videoMP4 = "video/mp4"
        
        enum CodingKeys: String, CodingKey {
            case type
        }
        
        init(from decoder: Decoder) throws {
            let singleValueContainer = try decoder.singleValueContainer()
            let stringValue = try singleValueContainer.decode(String.self)
            
            if let contentType = ContentType(rawValue: stringValue) {
                self = contentType
            } else {
                self = .unknown
            }
        }
    }
}
