//
//  CordinatorsFactory.swift
//  Gorilla
//
//  Created by Galushka on 3/13/19.
//  Copyright © 2019 Galushka.com. All rights reserved.
//

import UIKit

class CordinatorsFactory {
    
    func makeMainFlowCoordinator(_ navigationController: UINavigationController, _ serviceFactory: AppCoordinator.ServicesFactory) -> MainFlowCoordinator {
        return MainFlowCoordinator(navigationController: navigationController, servicesFactory: serviceFactory)
    }
}
