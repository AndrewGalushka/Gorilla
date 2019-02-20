//
// Created by Galushka on 2019-02-20.
// Copyright (c) 2019 Galushka.com. All rights reserved.
//

import Alamofire
import Foundation

protocol RequestRouter: URLRequestConvertible {
    var endPoint: NetworkEndPoint { get }
    var baseURLComponents: URLComponents? { get }
}

extension RequestRouter {
    public func asURLRequest() throws -> URLRequest {
        var urlComponents: URLComponents

        if let baseURLComponents = baseURLComponents {
            urlComponents = baseURLComponents
        } else {
            urlComponents = URLComponents()
            urlComponents.host = endPoint.host
            urlComponents.scheme = endPoint.scheme.rawValue
        }

        urlComponents.path = endPoint.path
        urlComponents.queryItems = endPoint.queryItems

        let request = try URLRequest(url: urlComponents, method: endPoint.httpMethod, headers: endPoint.httpHeaders)

        return request
    }
}
