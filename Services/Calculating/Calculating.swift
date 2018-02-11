//
//  Calculating.swift
//  UNO
//
//  Created by Богдан Маншилин on 09/02/2018.
//  Copyright © 2018 BManshilin. All rights reserved.
//

import Foundation
import Model

/// Range of rounds of the game
public enum RoundRange {
    /// All the game
    case total
    /// Exact round
    case just(Int)
    /// Serveral rounds
    case range(Range<Int>)
}

/// Calculator errors
public enum CalculatorError: Error {
    /// Attempt to request round that doesn't exist
    case requestedPosition(Int, outOfExistingRoundRange: Range<Int>)
    /// Attempt to create round with players other than plaing the game
    case inconsistentRound(allPlayers: [Player], got: [Player])
    /// Attempt to get info about player that does not participate in the game
    case requestedPlayerDoesNotParticipate(all: [Player], requested: Player)
}

/// The main UNO-game calculator. Holds all the game info: players and thier
/// scores by rounds. In can be initialized with a `GameCreator`
public protocol Calculating {
    /// All players participating in the game
    var players: [Player] { get }
    
    /// Rounds have calculated to this moment
    var roundsCount: Int { get }
    
    /// Scores limit
    var limit: Int { get }
    
    /// Handler that will be called when on of the players will exceed score limit
    var gameOverHandler: (([Player: Int]) -> Void)? { set get }
    
    /// Get total scroes for all players in specified range
    ///
    /// - Parameter within: range in wich scores must be calculated
    ///
    /// - Throws `CalculatorError.requestedPosition(_:outOfExistingRoundRange:_)`
    func score(within: RoundRange) throws -> [Player: Int]
    
    /// Get total scroe for specified player in specified range
    ///
    /// - Parameters:
    ///   - for: player for wich scores must be calculated
    ///   - within: range in wich scores must be calculated
    ///
    /// - Throws `CalculatorError.requestedPosition(_:outOfExistingRoundRange:_)`
    func score(for: Player, within: RoundRange) throws -> Int
    
    /// Add round. Round should be formed in given callback.
    ///
    /// It can trigger `gameOverHandler(_:)` if some player exceeded score limit
    ///
    /// - Parameters:
    ///   - createRoundHandler: callback to create and return round from
    ///   - for: players for witch round must be created. All players from this
    ///     array must be persist in returned Round
    ///
    /// - Throws `CalculatorError.inconsistentRound(allPlayers:_,got:_)`
    mutating func addRound(_ createRoundHandler: (_ for: [Player])->[Player: Int]) throws
}

extension Player: Hashable {
    public var hashValue: Int {
        return name.hashValue
    }
    
    public static func ==(lhs: Player, rhs: Player) -> Bool {
        return lhs.name == rhs.name
    }
}
