//
//  ImgurBaseTarget.swift
//  Gorilla
//
//  Created by Galushka on 3/5/19.
//  Copyright © 2019 Galushka.com. All rights reserved.
//

import Moya

protocol ImgurTarget: TargetType, ImgurAccessTokenAuthorizable {
}

extension ImgurTarget {
    
    var baseURL: URL {
        let baseURL: String = "https://api.imgur.com/3"
        
        return URL(string: baseURL)!
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var validationType: ValidationType {
        return .successCodes
    }
    
    var headers: [String: String]? {
        return nil
    }
    
    var imgurAuthorizationType: ImgurAccessType {
        return .clientID
    }
}

struct AnyImgurTarget: ImgurTarget {
    let baseURL: URL
    let path: String
    let method: Method
    let sampleData: Data
    let task: Task
    let headers: [String : String]?
    let imgurAuthorizationType: ImgurAccessType
    
    init(_ imgurTarget: ImgurTarget) {
        self.baseURL = imgurTarget.baseURL
        self.path = imgurTarget.path
        self.method = imgurTarget.method
        self.sampleData = imgurTarget.sampleData
        self.task = imgurTarget.task
        self.headers = imgurTarget.headers
        self.imgurAuthorizationType = imgurTarget.imgurAuthorizationType
    }
}
