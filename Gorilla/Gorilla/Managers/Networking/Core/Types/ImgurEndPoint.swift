//
// Created by Galushka on 2019-02-19.
// Copyright (c) 2019 Galushka.com. All rights reserved.
//

import Foundation

protocol ImgurEndPoint: NetworkEndPoint {
}

extension ImgurEndPoint {
    var scheme: URLSchemeType {
        return .https
    }
}
