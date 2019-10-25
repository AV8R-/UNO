//
//  StartGameCoordinator.swift
//  UNO
//
//  Created by Богдан Маншилин on 11/03/2018.
//  Copyright © 2018 BManshilin. All rights reserved.
//

import UIKit

final class StartGameCoordinator: Resolving {
    
    private let presenter: UINavigationController
    
    init(presenter: UINavigationController) {
        self.presenter = presenter
    }
    
    func start() throws {
        let rulesView = ChooseRulesView(viewModel: ChooseRulesViewModel(picker: try resolve()))
        let playersView = AddPlayersView(viewModel: AddPlayersViewModel(playersService: try resolve()))
        
        let startController = StepsViewController(pages: [rulesView, playersView], tintColor: .lightGreen)
        presenter.pushViewController(startController, animated: true)
        
        startController.onClose = { [weak presenter] in
            presenter?.popViewController(animated: true)
        }
    }
}
