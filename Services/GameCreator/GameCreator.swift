//
//  GameCreating.swift
//  Services
//
//  Created by Богдан Маншилин on 11/02/2018.
//  Copyright © 2018 BManshilin. All rights reserved.
//

import Foundation
import Model

/// Error in creating the game
enum CreateGameError: Error {
    /// Rules was not set to the Game Creator
    case rulesWasNotChosen
    
    /// 
    case wrongPlayersCount(got: Int, min: Int, max: Int)
}

public protocol GameCreator {
    
    /// Players from the history
    var recentPlayers: [Player] { get }
    
    /// Choose the rules for the game
    func set(rules: Rules)
    
    /// Add player to the game. If player was in recents,
    /// it will be deleted from that one.
    ///
    /// - Rethrows errors of type `ValidationError`
    func add(player: Player) throws
    
    /// Remove player for the game. If player was in recents,
    /// it will be recovered in that one.
    func remove(player: Player)
    
    /// Make calculator for the game
    ///
    /// - Throws Errors of type `CreateGameError`
    func makeGame() throws -> Calculating
}
