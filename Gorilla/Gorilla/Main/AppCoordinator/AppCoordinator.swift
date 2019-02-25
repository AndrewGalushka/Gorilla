//
// Created by Galushka on 2019-02-18.
// Copyright (c) 2019 Galushka.com. All rights reserved.
//

import UIKit


class AppCoordinator: AppCoordinatorType {

    // MARK: - Properties(Private)

    let window: UIWindow

    init(window: UIWindow) {
        self.window = window
    }

    func start() {
        let feedVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: String(describing: FeedViewController.self)) as! FeedViewController
        let navigationViewController = UINavigationController(rootViewController: feedVC)
        navigationViewController.navigationBar.barStyle = .blackTranslucent
        
        window.rootViewController = navigationViewController
        window.makeKeyAndVisible()
    }
}
