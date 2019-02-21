//
// Created by Galushka on 2019-02-21.
// Copyright (c) 2019 Galushka.com. All rights reserved.
//

import Foundation
import UIKit

class ImgurRequestBuilder: RequestBuilder {
    private(set) var endPoint: NetworkEndPoint
    var baseURLComponents: URLComponents? = nil

    init(endPoint: ImgurEndPoint) {
        self.endPoint = endPoint
    }
}
