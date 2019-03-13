//
//  UIStoryboard+StoryboardTypes.swift
//  Gorilla
//
//  Created by Galushka on 3/13/19.
//  Copyright © 2019 Galushka.com. All rights reserved.
//

import UIKit

extension UIStoryboard {
    
    enum Storyboard: String {
        case main
        
        var filename: String {
            return self.rawValue.capitalized
        }
    }
}

extension UIStoryboard {
    convenience init(storyboard: Storyboard, bundle: Bundle? = nil) {
        self.init(name: storyboard.filename, bundle: bundle)
    }
}
