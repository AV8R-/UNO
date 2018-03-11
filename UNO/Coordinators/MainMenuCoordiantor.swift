//
//  MainMenuCoordiantor.swift
//  UNO
//
//  Created by Богдан Маншилин on 11/03/2018.
//  Copyright © 2018 BManshilin. All rights reserved.
//

import UIKit
import Views

final class MainMenuCoordinator: Coordinator {
    private var presenter: UINavigationController
    private lazy var startGameCoordinator: StartGameCoordinator = {
        return StartGameCoordinator(presenter: presenter)
    }()
    
    init(presenter: UINavigationController) {
        self.presenter = presenter
    }
    
    func start() {
        let mainMenu = MainMenuView()
        mainMenu.delegate = self
        presenter.pushViewController(mainMenu, animated: false)
    }
}

extension MainMenuCoordinator: MainMenuDelegate {
    func didSelect(menuItem: MainMenuView.MenuItem) {
        startGameCoordinator.start()
    }
}
