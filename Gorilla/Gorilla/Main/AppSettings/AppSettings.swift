//
//  AppSettings.swift
//  Gorilla
//
//  Created by Galushka on 3/12/19.
//  Copyright © 2019 Galushka.com. All rights reserved.
//

import Foundation
import UIKit.UIApplication

struct AppSettings {
    
    // MARK: - Properties(Public)
    
    let imgur: Imgur = Imgur()
    
    // MARK: - Properties(Private)
    
    private let launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    
    // MARK: - Initializers
    
    init(launchOptions: [UIApplication.LaunchOptionsKey: Any]?) {
        self.launchOptions = launchOptions
    }
    
    struct Imgur {
        let clientID: String = "6a1d17a3a133ad8"
        let secret: String = "a9424b369221ed1701c18552548a4b215d81ff7b"
    }
}
