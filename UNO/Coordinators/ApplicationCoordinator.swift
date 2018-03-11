//
//  ApplicationCoordinator.swift
//  UNO
//
//  Created by Богдан Маншилин on 11/03/2018.
//  Copyright © 2018 BManshilin. All rights reserved.
//

import UIKit
import Views

final class ApplicationCoordinator: Coordinator {
    let window: UIWindow
    let rootViewController: UINavigationController
    
    init(window: UIWindow) {
        self.window = window
        rootViewController = UINavigationController()
        rootViewController.isNavigationBarHidden = true
        
        let mainMenu = MainMenuView()
        mainMenu.delegate = self
        rootViewController.pushViewController(mainMenu, animated: false)
    }
    
    func start() {
        window.rootViewController = rootViewController
        window.makeKeyAndVisible()
    }
}

extension ApplicationCoordinator: MainMenuDelegate {
    func didSelect(menuItem: MainMenuView.MenuItem) {
        print("didSelect \(menuItem)")
    }
}
