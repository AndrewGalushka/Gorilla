//
//  Module.swift
//  Gorilla
//
//  Created by Galushka on 3/13/19.
//  Copyright © 2019 Galushka.com. All rights reserved.
//

import UIKit

protocol ScreenModule: AnyObject {
    var ownedViewController: UIViewController { get }
}
