import Foundation
import Quick
import Nimble

@testable import UNO

final class CalculatorSpec: QuickSpec {
   
    override func spec() {
        var calculator: Calculator!
        var players: [Player]!

        let limit = 500
        let firstPlayerScoresPerRound = 5
        let secondPlayerScoresPerRound = 10
        let thirdPlayerScoresPerRound = 8

        let round = { (_: [Player]) -> [Player : Int] in
            return [
                players[0]: firstPlayerScoresPerRound,
                players[1]: secondPlayerScoresPerRound,
                players[2]: thirdPlayerScoresPerRound,
            ]
        }
        
        describe("calculator") {
            beforeEach {
                players = Stubs.game.players
                calculator = try! Calculator(rules: .max(limit: 500), players: players)
            }
            
            describe("add round") {
                it("executes without thorwing") {
                    do {
                        try calculator.addRound(round)
                    } catch {
                        fail("\(error)")
                    }
                }
                
                it("increments rounds count") {
                    let rounds = calculator.roundsCount
                    try! calculator.addRound(round)
                    
                    expect(calculator.roundsCount).to(equal(rounds+1))
                    expect(calculator.scores[players.first!]).toNot(beNil())
                    expect(calculator.scores[players.last!]).toNot(beNil())
                    expect(calculator.scores[players.first!]!.count).to(equal(rounds+1))
                    expect(calculator.scores[players.last!]!.count).to(equal(rounds+1))
                }
            }
            
            describe("scores") {
                context("with 3 rounds played") {
                    beforeEach {
                        try! calculator.addRound(round)
                        try! calculator.addRound(round)
                        try! calculator.addRound(round)
                    }
                    
                    it("calculates for one round") {
                        do {
                            let scores = try calculator
                                .score(for: players.first!, within: .just(0))
                            expect(scores).to(equal(firstPlayerScoresPerRound))
                        } catch {
                            fail("\(error)")
                        }
                    }
                    
                    it("calculates for two rounds") {
                        do {
                            let scores = try calculator
                                .score(for: players.first!, within: .range(0..<2))
                            expect(scores).to(equal(firstPlayerScoresPerRound*2))
                        } catch {
                            fail("\(error)")
                        }
                    }
                    
                    it("calculates for all rounds") {
                        do {
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
                }
            }
            
            describe("finish") {
                it("triggers on limint reached") {
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
}
