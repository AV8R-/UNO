//
//  StartGameCoordinator.swift
//  UNO
//
//  Created by Богдан Маншилин on 11/03/2018.
//  Copyright © 2018 BManshilin. All rights reserved.
//

import UIKit
import Views
import ViewModels
import Core_UI

final class StartGameCoordinator: Coordinator, Resolving {
    
    private let presenter: UINavigationController
    
    init(presenter: UINavigationController) {
        self.presenter = presenter
        
    }
    
    func start() throws {
        let rulesView: ChooseRulesViewControlling = try resolve()
        let playersView: AddPlayersViewControlling = try resolve()
        
        let startController = StepsViewController(pages: [rulesView, playersView], tintColor: .lightGreen)
        presenter.pushViewController(startController, animated: true)
        
        startController.onClose = { [weak presenter] in
            presenter?.popViewController(animated: true)
        }
    }
}
