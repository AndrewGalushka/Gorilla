//
// Created by Galushka on 2019-02-21.
// Copyright (c) 2019 Galushka.com. All rights reserved.
//

import Foundation

protocol JSONDecodable {
    associatedtype OutputModel: Decodable
    func decodeJSONData(_ data: Data) -> OutputModel?
}