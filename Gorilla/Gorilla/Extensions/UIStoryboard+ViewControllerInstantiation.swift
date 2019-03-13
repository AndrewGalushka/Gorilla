//
//  UIStoryboard+ViewControllerInstantiation.swift
//  Gorilla
//
//  Created by Galushka on 3/13/19.
//  Copyright © 2019 Galushka.com. All rights reserved.
//

import UIKit

extension UIStoryboard {
    
    func instantiate<V: UIViewController & InterfaceBuilderIdentifiable>(_ viewControllerType: V.Type) -> V {
        return instantiateViewController(withIdentifier: viewControllerType.interfaceBuilderIdentifier) as! V
    }
}
