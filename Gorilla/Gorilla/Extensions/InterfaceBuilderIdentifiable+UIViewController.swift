//
//  UIViewController+InterfaceBuilderIdentifiable.swift
//  Gorilla
//
//  Created by Galushka on 3/13/19.
//  Copyright © 2019 Galushka.com. All rights reserved.
//

import UIKit

extension InterfaceBuilderIdentifiable where Self: UIViewController {
    
    static var interfaceBuilderIdentifier: String {
        let fullClassName = NSStringFromClass(self)
        
        if let lastComponentName = fullClassName.components(separatedBy: ".").last {
            return lastComponentName
        } else {
            return fullClassName
        }
    }
}

