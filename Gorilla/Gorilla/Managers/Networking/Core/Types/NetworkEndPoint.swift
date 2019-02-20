//
// Created by Galushka on 2019-02-19.
// Copyright (c) 2019 Galushka.com. All rights reserved.
//

import UIKit

protocol NetworkEndPoint {
    var scheme: NetworkSchemeType { get }
    var baseURL: String { get }
    var path: String { get }
    var queryParams: [URLQueryItem]? { get }
    var httpMethod: HTTPMethod { get }
}
