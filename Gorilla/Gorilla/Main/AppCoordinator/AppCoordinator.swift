//
// Created by Galushka on 2019-02-18.
// Copyright (c) 2019 Galushka.com. All rights reserved.
//

import UIKit

class AppCoordinator: FlowCoordinator {

    // MARK: - Properties(Public)
    
    var rootViewController: UIViewController {
        return self.navigationController
    }
    
    // MARK: - Properties(Private)

    private let window: UIWindow
    private var navigationController: UINavigationController
    private let appSettings: AppSettings
    private let servicesFactory: ServicesFactory
    private let coordinatorsFactory: CordinatorsFactory = CordinatorsFactory()
    private var childCoordinators = [FlowCoordinator]()
    
    // MARK: - Intializers
    
    init(window: UIWindow, appSettings: AppSettings) {
        self.window = window
        self.appSettings = appSettings
        self.servicesFactory = ServicesFactory(appSettings: appSettings)
        self.navigationController = UINavigationController()
    }

    func start() {
        navigationController.navigationBar.barStyle = .blackTranslucent
        
        let mainFlowCoordinator = self.coordinatorsFactory.makeMainFlowCoordinator(self.navigationController, self.servicesFactory)
        mainFlowCoordinator.start()
        self.addChildCoordinator(mainFlowCoordinator)
    }
    
    // MARK: - Methods(Private)
    
    private func addChildCoordinator(_ coordinator: FlowCoordinator) {
        childCoordinators.append(coordinator)
    }
    
    private func removeChildCoordinator(_ coordinator: FlowCoordinator) {
        childCoordinators.removeAll { $0 === coordinator }
    }
}

extension AppCoordinator {
    
    class ServicesFactory {
        
        // MARK: - Properties(Public)
        
        let imgurRequestManager: ImgurRequestManager
        
        // MARK: - Properties(Private)
        
        private let appSettings: AppSettings
        
        // MARK: - Initializers
        
        fileprivate init(appSettings: AppSettings) {
            self.appSettings = appSettings
            self.imgurRequestManager = ImgurRequestManager(clientID: appSettings.imgur.clientID)
        }
    }
}
