//
//  GameCreating.swift
//  Services
//
//  Created by Богдан Маншилин on 11/02/2018.
//  Copyright © 2018 BManshilin. All rights reserved.
//

import Foundation

/// Error in creating the game
enum CreateGameError: Error {
    /// Wrong players count
    case wrongPlayersCount(got: Int, min: Int, max: Int)
}

public protocol GameCreating {
    
    /// Players from the history
    var recentPlayers: [Player] { get }
    
    /// Add player to the game. If player was in recents,
    /// it will be deleted from that one.
    ///
    /// - Rethrows errors of type `ValidationError`
    mutating func add(player: Player) throws
    
    /// Remove player for the game. If player was in recents,
    /// it will be recovered in that one.
    mutating func remove(player: Player)
    
    /// Make calculator for the game
    ///
    /// - Throws Errors of types `CreateGameError`, `ValidationError`
    func makeGame(rules: Rules) throws -> Calculating
}
