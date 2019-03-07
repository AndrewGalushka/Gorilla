//
// Created by Galushka on 2019-03-04.
// Copyright (c) 2019 Galushka.com. All rights reserved.
//

import Foundation

protocol ClientIDProvidable {
    var clientID: String { get }
}

protocol SecretProvidable {
    var secret: String { get }
}

protocol TokenProvidable {
    var token: String { get }
}