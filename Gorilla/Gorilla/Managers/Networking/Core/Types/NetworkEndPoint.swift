//
// Created by Galushka on 2019-02-19.
// Copyright (c) 2019 Galushka.com. All rights reserved.
//

import Foundation
import Alamofire

protocol NetworkEndPoint {
    var httpMethod: HTTPMethod { get }
    var scheme: URLSchemeType { get }
    var host: String { get }
    var path: String { get }
    var queryItems: [URLQueryItem]? { get }
    var httpHeaders: HTTPHeaders? { get }
}
