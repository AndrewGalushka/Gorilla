//
//  LoadingViewController.swift
//  Gorilla
//
//  Created by Galushka on 3/13/19.
//  Copyright © 2019 Galushka.com. All rights reserved.
//

import UIKit

class LaunchProgressViewController: UIViewController {
    private let gradientLayer = CAGradientLayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupGradient()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        self.gradientLayer.frame = self.view.bounds
    }
    
    private func setupGradient() {
        self.gradientLayer.colors = [UIColor.cyan.cgColor, UIColor.white.cgColor]
        self.gradientLayer.type = .conic
        self.gradientLayer.frame = self.view.bounds
        self.view.layer.addSublayer(self.gradientLayer)
    }
}
