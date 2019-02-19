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
        let rootVC = UIViewController()
        rootVC.view.backgroundColor = .red

        window.rootViewController = rootVC
        window.makeKeyAndVisible()
    }
}