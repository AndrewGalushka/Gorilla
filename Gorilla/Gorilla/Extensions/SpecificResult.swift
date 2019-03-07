//
//  SpecificResult.swift
//  Gorilla
//
//  Created by Galushka on 3/7/19.
//  Copyright © 2019 Galushka.com. All rights reserved.
//

import Foundation

enum SpecificResult<SuccesType, ErrorType: Error> {
    case success(SuccesType)
    case failure(ErrorType)
}
