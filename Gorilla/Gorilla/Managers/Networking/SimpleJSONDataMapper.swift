//
//  JSONDataMapper.swift
//  Gorilla
//
//  Created by Galushka on 3/7/19.
//  Copyright © 2019 Galushka.com. All rights reserved.
//

import Foundation

class SimpleJSONDataMapper<D: Decodable>: JSONDataDecodable {
    
    func decodeJSONData(_ data: Data) throws -> D {
        return try JSONDecoder().decode(D.self, from: data)
    }
}
