//
//  CalculatorSpec.swift
//  UNOTests
//
//  Created by Богдан Маншилин on 10/02/2018.
//  Copyright © 2018 BManshilin. All rights reserved.
//

import Quick
import Nimble
import Model
@testable import Services

final class CalculatorSpec: QuickSpec {
    struct MockCreating: GameCreating {
        var players: [Player]
        var rules: Rules
        var scoresLimit: Int {
            return try! rules.limit()
        }
    }
    
    override func spec() {
        var calculator: Calculating!

        let players = try! ["First", "Second"].map(Player.init)
        let limit = 500
        let creating = MockCreating(players: players, rules: .min(limit: limit))
        let firstPlayerScoresPerRound = 5
        let secondPlayerScoresPerRound = 10

        let round = { (_: [Player]) -> [Player : Int] in
            return [
                players[0]: firstPlayerScoresPerRound,
                players[1]: secondPlayerScoresPerRound
            ]
        }
        
        describe("calculator") {
            beforeEach {
                calculator = Calculator(creator: creating)
            }
            
            it("should add rounds") {
                do {
                    try calculator.addRound(round)
                } catch {
                    fail("\(error)")
                }
            }
            
            it("should increment rounds count on round add") {
                let rounds = calculator.roundsCount
                try! calculator.addRound(round)
                expect(rounds+1).to(equal(calculator.roundsCount))
            }
            
            it("sould retrieve scores for one round") {
                do {
                    try! calculator.addRound(round)
                    let scores = try calculator.score(for: players.first!, within: .just(0))
                    expect(scores).to(equal(firstPlayerScoresPerRound))
                } catch {
                    fail("\(error)")
                }
            }
            
            it("sould retrieve scores for range of rounds") {
                do {
                    try calculator.addRound(round)
                    try calculator.addRound(round)
                    let scores = try calculator
                        .score(for: players.first!, within: .range(0..<2))
                    expect(scores).to(equal(firstPlayerScoresPerRound*2))
                } catch {
                    fail("\(error)")
                }

            }
            
            it("should retrieve total scores") {
                do {
                    try calculator.addRound(round)
                    try calculator.addRound(round)
                    try calculator.addRound(round)
                    
                    let scores = try calculator
                        .score(for: players.first!, within: .total)
                    let perRound = firstPlayerScoresPerRound
                    let rounds = calculator.roundsCount
                    let total = perRound * rounds
                    expect(scores).to(equal(total))
                } catch {
                    fail("\(error)")
                }
            }
            
            it("should finish the game when limit reached") {
                let lastRound = { (_: [Player]) -> [Player: Int] in
                    return [players[0]: limit, players[1]: 0]
                }
                var gameOverCalls = 0
                calculator.gameOverHandler = { _ in
                    gameOverCalls += 1
                }
                do {
                    try calculator.addRound(lastRound)
                } catch {
                    fail("\(error)")
                }
                expect(gameOverCalls).to(equal(1))
            }
            
        }
    }
}
