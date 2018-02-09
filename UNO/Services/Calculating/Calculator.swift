//
//  Calculator.swift
//  UNO
//
//  Created by Богдан Маншилин on 10/02/2018.
//  Copyright © 2018 BManshilin. All rights reserved.
//

import Foundation

struct Calculator: Calculating {
    var players: [Player] {
        return scores.keys.map { $0 }
    }
    private(set) var roundsCount = 0
    
    private var scores: [Player: [Int]]
    
    init(players: [Player]) {
        self.scores = players
            .map { ($0, [Int]()) }
            .toDictionary()
    }

    func score(within: RoundRange) throws -> [Player: Int] {
        switch within {
        case .just(let round):
            return scores
                .map { ($0.key, $0.value[round]) }
                .toDictionary()
            
        case .range(let range):
            return scores
                .map { ($0.key, $0.value[range].reduce(0) { $0 + $1 } ) }
                .toDictionary()
        case .total:
            return try score(within: .range(0..<roundsCount))
        }
    }
    
    func score(for: Player, within: RoundRange) throws -> Int {
        guard let score = try score(within: within)[`for`] else {
            throw CalculatorError.requestedPlayerDoesNotParticipate(
                all: players,
                requested: `for`
            )
        }
        
        return score
    }
    
    mutating func addRound(
        _ createRoundHandler: (_ for: [Player])->[Player: Int]
        ) throws
    {
        scores = try createRoundHandler(players).reduce(scores) {
            var scores = $0
            guard var array = scores[$1.key] else {
                throw CalculatorError.inconsistentRound(
                    allPlayers: players,
                    got: createRoundHandler(players).keys.map {$0}
                )
            }
            
            array.append($1.value)
            scores[$1.key] = array
            return scores
        }
        roundsCount += 1
    }
}

extension Array {
    func toDictionary<K,V>() -> [K:V] where Iterator.Element == (K,V) {
        return self.reduce([:]) {
            var dict:[K:V] = $0
            dict[$1.0] = $1.1
            return dict
        }
    }
}
