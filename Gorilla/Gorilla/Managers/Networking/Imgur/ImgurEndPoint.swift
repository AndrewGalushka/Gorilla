//
// Created by Galushka on 2019-02-19.
// Copyright (c) 2019 Galushka.com. All rights reserved.
//

import Foundation

protocol ImgurEndPoint: NetworkEndPoint {
    var clientID: String { get }
    var clientSecret: String { get }
}

extension ImgurEndPoint {
    var scheme: URLSchemeType {
        return .https
    }
}
