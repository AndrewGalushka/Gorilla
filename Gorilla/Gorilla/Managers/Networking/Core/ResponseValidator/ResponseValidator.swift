//
//  NetworkErrorValidator.swift
//  Gorilla
//
//  Created by Galushka on 2/27/19.
//  Copyright © 2019 Galushka.com. All rights reserved.
//

import Foundation

class ResponseValidator<ErrorType: Error> {
    
    enum ValidatingResult {
        case success
        case failure(Error)
    }
    
    func validate(response: NetworkDataResponse) -> ValidatingResult {
        return .failure(StandartError.noInternetConnection)
    }
    
    func concreateError(from: Error) -> ErrorType? {
        return nil
    }
}

extension ResponseValidator {
    
    enum StandartError: Error {
        case noInternetConnection
    }
}
