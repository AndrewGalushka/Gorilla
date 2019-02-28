//
// Created by Galushka on 2019-02-20.
// Copyright (c) 2019 Galushka.com. All rights reserved.
//

import Alamofire
import Foundation

protocol RequestBuilder: class, URLRequestConvertible {
    var endPoint: NetworkEndPoint { get }
    var baseURLComponents: URLComponents? { get }
    
    var path: String { get }
    var httpHeaders: HTTPHeaders? { get }
}

extension RequestBuilder {
    var baseURLComponents: URLComponents? { return nil }
    var path: String { return endPoint.path }
    var httpHeaders: HTTPHeaders? { return endPoint.httpHeaders }
    
    public func asURLRequest() throws -> URLRequest {
        var urlComponents: URLComponents

        if let baseURLComponents = baseURLComponents {
            urlComponents = baseURLComponents
        } else {
            urlComponents = URLComponents()
            urlComponents.host = endPoint.host
            urlComponents.scheme = endPoint.scheme.rawValue
        }

        urlComponents.path.append(self.path)
        urlComponents.queryItems = endPoint.queryItems

        do {
            let request = try URLRequest(url: urlComponents, method: endPoint.httpMethod, headers: self.httpHeaders)
            
            return request
        } catch (let error) {
            throw error
        }
    }
}
