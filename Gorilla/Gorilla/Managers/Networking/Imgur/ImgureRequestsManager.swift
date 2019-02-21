//
// Created by Galushka on 2019-02-20.
// Copyright (c) 2019 Galushka.com. All rights reserved.
//

import Alamofire
import Foundation

class ImgureRequestsManager {

    private lazy var sessionManager: SessionManager = {
        let sessionManager = SessionManager(configuration: self.sessionConfiguration)

        return sessionManager
    }()

    private var sessionConfiguration: URLSessionConfiguration {
        return URLSessionConfiguration.default
    }

    func execute(_ endPoint: ImgurEndPoint) {

    }
}
