//
//  StartGameCoordinator.swift
//  UNO
//
//  Created by Богдан Маншилин on 11/03/2018.
//  Copyright © 2018 BManshilin. All rights reserved.
//

import UIKit
import Views

final class StartGameCoordinator: Coordinator {
    
    private let presenter: UINavigationController
    
    init(presenter: UINavigationController) {
        self.presenter = presenter
        
    }
    
    func start() {
        let startController = StartNewGameView()
        presenter.pushViewController(startController, animated: true)
    }
}
