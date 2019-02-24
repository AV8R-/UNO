//
//  Register.swift
//  Services
//
//  Created by Богдан Маншилин on 23/03/2018.
//  Copyright © 2018 BManshilin. All rights reserved.
//

import Foundation
import Swinject

enum ServicesAssembley {
    static func register(container: Container) {
        container.register(GameCreating.self) { _ in GameCreator() }
        container.register(RulesPicking.self) { _ in RulesPicker() }
    }
}
