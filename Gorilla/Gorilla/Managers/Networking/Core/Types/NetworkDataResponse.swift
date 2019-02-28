//
//  NetworkDataResponse.swift
//  Gorilla
//
//  Created by Galushka on 2/27/19.
//  Copyright © 2019 Galushka.com. All rights reserved.
//

import Foundation

protocol NetworkDataResponse {
    var request: URLRequest? { get }
    var response: HTTPURLResponse? { get }
    var data: Data? { get }
    var error: Error? { get }
}
