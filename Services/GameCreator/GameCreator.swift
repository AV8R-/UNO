//
//  GameCreator.swift
//  Services
//
//  Created by Богдан Маншилин on 15/02/2018.
//  Copyright © 2018 BManshilin. All rights reserved.
//

import Foundation
import Model

struct GameCreator: GameCreating {
    enum Constants {
        static let minPlayers = 2
        static let maxPlayers = 12
    }
    
    var players: [Player] = []
    
    var recentPlayers: [Player] {
        return []
    }
    
    mutating func add(player: Player) throws {
        players.append(player)
    }
    
    mutating func remove(player: Player) {
        players = players.filter { $0.name != player.name }
    }
    
    func makeGame(rules: Rules) throws -> Calculating {
        guard players.count + 1 > Constants.minPlayers ||
            players.count + 1 < Constants.minPlayers else
        {
            throw CreateGameError.wrongPlayersCount(
                got: players.count,
                min: Constants.minPlayers,
                max: Constants.maxPlayers
            )
        }
        
        return try Calculator(rules: rules, players: players)
    }
    
    
}
