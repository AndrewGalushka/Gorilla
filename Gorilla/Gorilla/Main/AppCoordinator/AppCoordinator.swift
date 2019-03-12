//
// Created by Galushka on 2019-02-18.
// Copyright (c) 2019 Galushka.com. All rights reserved.
//

import UIKit

class AppCoordinator: Coordinator {

    // MARK: - Properties(Private)

    private let window: UIWindow
    private let appSettings: AppSettings
    private let serviceFactory: ServicesFactory

    // MARK: - Intializers
    
    init(window: UIWindow, appSettings: AppSettings) {
        self.window = window
        self.appSettings = appSettings
        self.serviceFactory = ServicesFactory(appSettings: appSettings)
    }

    func start() {
        let feedVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: String(describing: FeedViewController.self)) as! FeedViewController
        let navigationViewController = UINavigationController(rootViewController: feedVC)
        navigationViewController.navigationBar.barStyle = .blackTranslucent
        
        window.rootViewController = navigationViewController
        window.makeKeyAndVisible()
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
