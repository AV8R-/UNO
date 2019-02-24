//
//  ApplicationCoordinator.swift
//  UNO
//
//  Created by Богдан Маншилин on 11/03/2018.
//  Copyright © 2018 BManshilin. All rights reserved.
//

import UIKit

final class ApplicationCoordinator: Coordinator {
    let window: UIWindow
    let rootViewController: UINavigationController
    let mainMenu: MainMenuCoordinator
    
    init(window: UIWindow) {
        self.window = window
        rootViewController = UINavigationController()
        rootViewController.isNavigationBarHidden = true
        mainMenu = MainMenuCoordinator(presenter: rootViewController)
    }
    
    func start() {
        mainMenu.start()
        window.rootViewController = rootViewController
        window.makeKeyAndVisible()
    }
}
