//
//  Register.swift
//  ViewModels
//
//  Created by Богдан Маншилин on 23/03/2018.
//  Copyright © 2018 BManshilin. All rights reserved.
//

import Foundation
import Swinject
import Services

public func assemble(to container: Container) {
    container.register(ChooseRulesViewModelling.self) { r in
        ChooseRulesViewModel(picker: r.resolve(RulesPicking.self)!)
    }
    container.register(AddPlayersViewModelling.self) { r in
        AddPlayersViewModel(playersService: r.resolve(GameCreating.self)!)
    }
}
