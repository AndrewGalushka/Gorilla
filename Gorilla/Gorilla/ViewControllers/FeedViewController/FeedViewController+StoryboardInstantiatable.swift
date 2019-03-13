//
//  FeedViewController+StoryboardInstantiatable.swift
//  Gorilla
//
//  Created by Galushka on 3/13/19.
//  Copyright © 2019 Galushka.com. All rights reserved.
//

import UIKit

extension FeedViewController: StoryboardInstantiatable {
    static var associatedStoryboard: UIStoryboard.Storyboard {
        return .main
    }
}
