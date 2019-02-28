//
//  RequestModule.swift
//  Gorilla
//
//  Created by Galushka on 2/25/19.
//  Copyright © 2019 Galushka.com. All rights reserved.
//

import Foundation

class NetworkRequestModule<ResponseMappingResult: Decodable> {
    var endPoint: NetworkEndPoint
    var requestBuilder: RequestBuilder
    var responseModelType: ResponseMappingResult.Type
    
    init(endPoint: NetworkEndPoint, requestBuilder: RequestBuilder, responseModelType: ResponseMappingResult.Type) {
        self.endPoint = endPoint
        self.requestBuilder = requestBuilder
        self.responseModelType = responseModelType
    }
}
