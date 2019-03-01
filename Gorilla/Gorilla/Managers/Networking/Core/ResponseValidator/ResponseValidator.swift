//
// Created by Galushka on 2019-02-28.
// Copyright (c) 2019 Galushka.com. All rights reserved.
//

import Foundation

enum ResponseValidationError<CustomErrorType: Error>: Error {
    case urlSessionError(URLSessionError)
    case httpError(HTTPResponseError)
    case customError(CustomErrorType)
}

enum ResponseValidatingResult<CustomErrorType: Error> {
    case success
    case failure(ResponseValidationError<CustomErrorType>)
}

protocol ResponseValidator {
    associatedtype CustomErrorType: Error

    func validate(_ requestResult: NetworkDataResponse) -> ResponseValidatingResult<CustomErrorType>

    func validateHTTPResponse(_ response: HTTPURLResponse) -> HTTPResponseError?
    func validateURLSessionError(_ error: Error) -> URLSessionError
    func validateForCustomError(requestResult: NetworkDataResponse) -> CustomErrorType?
}

extension ResponseValidator {
    func validate(_ requestResult: NetworkDataResponse) -> ResponseValidatingResult<CustomErrorType> {

        if let error = requestResult.error {
            return .failure(.urlSessionError(self.validateURLSessionError(error)))
        } else if let urlResponse = requestResult.response, let httpRequestError = validateHTTPResponse(urlResponse) {
            return .failure(.httpError(httpRequestError))
        } else if let customError = validateForCustomError(requestResult: requestResult) {
            return .failure(.customError(customError))
        }

        return .success
    }

    func validateHTTPResponse(_ response: HTTPURLResponse) -> HTTPResponseError? {
        return HTTPResponseError(rawValue: response.statusCode)
    }

    func validateURLSessionError(_ error: Error) -> URLSessionError {
        return URLSessionError.sessionError(from: error as NSError)
    }
}


