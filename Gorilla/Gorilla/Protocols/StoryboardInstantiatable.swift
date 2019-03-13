//
//  UIViewController+StoryboardInstantiatable.swift
//  Gorilla
//
//  Created by Galushka on 3/13/19.
//  Copyright © 2019 Galushka.com. All rights reserved.
//

import UIKit

protocol StoryboardInstantiatable: InterfaceBuilderIdentifiable {
    static var associatedStoryboard: UIStoryboard.Storyboard { get }
    static func instantiateFromStoryboard() -> Self
}

extension StoryboardInstantiatable where Self: UIViewController {
    
    static func instantiateFromStoryboard() -> Self {
        return UIStoryboard(storyboard: associatedStoryboard).instantiate(self)
    }
}
