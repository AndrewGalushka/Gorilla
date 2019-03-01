//
// Created by Galushka on 2019-03-01.
// Copyright (c) 2019 Galushka.com. All rights reserved.
//

import Foundation

enum URLSessionError: RawRepresentable, Error {
    typealias RawValue = NSError

    case unknown(NSError)
    case noInternetConnection(NSError)

    init?(rawValue: NSError) {
        self = URLSessionError.sessionError(from: rawValue)
    }

    static func sessionError(from error: NSError) -> URLSessionError {
        switch error.code {
        case -1009:
            return .noInternetConnection(error)
        default:
            return .unknown(error)
        }
    }

    var rawValue: NSError {

        switch self {
        case .unknown(let error):
            return error
        case .noInternetConnection(let error):
            return error
        }
    }
}