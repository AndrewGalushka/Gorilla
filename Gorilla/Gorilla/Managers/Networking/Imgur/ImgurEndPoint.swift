//
// Created by Galushka on 2019-02-19.
// Copyright (c) 2019 Galushka.com. All rights reserved.
//

import Foundation
import Alamofire

protocol ImgurEndPoint: NetworkEndPoint {
    var clientID: String { get }
    var clientSecret: String { get }
}

extension ImgurEndPoint {
    var clientID: String {
        return "6a1d17a3a133ad8"
    }

    var scheme: URLSchemeType {
        return .https
    }

    var host: String { return "api.imgur.com/3/" }
    var httpHeaders: HTTPHeaders? { return ["Authorization": "Client-ID \(clientID)"] }
}
