//
//  NetworkErrorValidator.swift
//  Gorilla
//
//  Created by Galushka on 2/27/19.
//  Copyright © 2019 Galushka.com. All rights reserved.
//

import Foundation

class ResponseValidator {
    
    enum ValidatingResult {
        case success(HTTPURLResponse, Data?)
        case failure(ValidationError)
    }

    func validate(_ requestResult: NetworkDataResponse) -> ValidatingResult {

        if let error = requestResult.error {
            return .failure(.urlSessionError(validateURLSessionError(error)))
        } else if let httpResponse = requestResult.response {

            if let httpError = validateHTTPResponse(httpResponse) {
                return  .failure(.httpError(httpError))
            }

            return .success(httpResponse, requestResult.data)
        } else {
            return .failure(.other)
        }
    }

    func validateHTTPResponse(_ response: HTTPURLResponse) -> HTTPError? {
        return HTTPError(rawValue: response.statusCode)
    }

    func validateURLSessionError(_ error: Error) -> URLSessionError {
        return URLSessionError(rawValue: error)
    }

    enum ValidationError: Error {
        case urlSessionError(URLSessionError)
        case httpError(HTTPError)
        case other
    }
}

extension ResponseValidator {
    
    enum HTTPError: RawRepresentable, Error {
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

    enum URLSessionError: RawRepresentable, Error {
        typealias RawValue = NSError

        case unknown(NSError)
        case noInternetConnection(NSError)

        init?(rawValue: NSError) {

            switch rawValue.code {
            case -1009:
                self = .noInternetConnection(rawValue)
            default:
                self = .unknown(rawValue)
            }
        }
    }
}
