//
//  Register.swift
//  Views
//
//  Created by Богдан Маншилин on 23/03/2018.
//  Copyright © 2018 BManshilin. All rights reserved.
//

import Foundation
import Swinject
import ViewModels

public func register(container: Container) {
    container.register(MainMenuViewControlling.self) { _ in MainMenuView() }
    container.register(ChooseRulesViewControlling.self) { r in
        let vm = r.resolve(ChooseRulesViewModelling.self)!
        return ChooseRulesViewController(viewModel: vm, io: vm.io)
    }
}
