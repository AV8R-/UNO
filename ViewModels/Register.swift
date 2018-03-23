//
//  Register.swift
//  ViewModels
//
//  Created by Богдан Маншилин on 23/03/2018.
//  Copyright © 2018 BManshilin. All rights reserved.
//

import Foundation
import Swinject

public func register(container: Container) {
    container.register(ChooseRulesViewModelling.self) { _ in ChooseRulesViewModel() }
}
