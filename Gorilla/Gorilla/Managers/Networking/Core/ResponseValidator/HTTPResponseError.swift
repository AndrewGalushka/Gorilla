//
// Created by Galushka on 2019-03-01.
// Copyright (c) 2019 Galushka.com. All rights reserved.
//

import Foundation

enum HTTPResponseError: RawRepresentable, Error {
    typealias RawValue = Int

    case redirection(Int)
    case clientError(Int)
    case serverError(Int)

    init?(rawValue: Int) {

        switch rawValue {
        case 300...399:
            self = .redirection(rawValue)
        case 400...499:
            self = .clientError(rawValue)
        case 500...599:
            self = .serverError(rawValue)
        default:
            return nil
        }
    }

    var rawValue: Int {
        switch self {
        case .redirection(let statusCode):
            return statusCode
        case .clientError(let statusCode):
            return statusCode
        case .serverError(let statusCode):
            return statusCode
        }
    }
}
