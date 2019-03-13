//
//  MainFlowCoordinator.swift
//  Gorilla
//
//  Created by Galushka on 3/12/19.
//  Copyright © 2019 Galushka.com. All rights reserved.
//

import UIKit

class MainFlowCoordinator: Coordinator {
    
    private let navigationController: UINavigationController
    private let servicesFactory: AppCoordinator.ServicesFactory
    
    init(navigationController: UINavigationController, servicesFactory: AppCoordinator.ServicesFactory) {
        self.navigationController = navigationController
        self.servicesFactory = servicesFactory
    }
    
    func start() {
    }
}
