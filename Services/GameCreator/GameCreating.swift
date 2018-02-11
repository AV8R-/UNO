//
//  GameCreating.swift
//  Services
//
//  Created by Богдан Маншилин on 11/02/2018.
//  Copyright © 2018 BManshilin. All rights reserved.
//

import Foundation
import Model

internal protocol GameCreating {
    var players: [Player] { get }
    var rules: Rules { get }
    var scoresLimit: Int { get }
}
