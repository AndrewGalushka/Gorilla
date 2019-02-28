//
// Created by Galushka on 2019-02-21.
// Copyright (c) 2019 Galushka.com. All rights reserved.
//

import Foundation
import UIKit

class ImgurRequestBuilder {
    private var imgureEndPoint: ImgurEndPoint

    init(endPoint: ImgurEndPoint) {
        self.imgureEndPoint = endPoint
    }
}

extension ImgurRequestBuilder: RequestBuilder {
    var endPoint: NetworkEndPoint { return imgureEndPoint }
    var path: String {
        return "/\(imgureEndPoint.apiVersion)\(self.imgureEndPoint.path)"
    }
}
