import Foundation
@testable import UNO

class GameCreatingMock: GameCreating {
    var addCalledTimes = 0
    var removeCalledTimes = 0
    var makeGameCalledTimes = 0
    
    var gameStub = Stubs.game
    
    var recentPlayers: [Player] = []
    func add(player: Player) throws {
        addCalledTimes += 1
    }
    
    func remove(player: Player) {
        removeCalledTimes += 1
    }
    
    func makeGame(rules: Rules) throws -> Calculating {
        makeGameCalledTimes += 1
        return gameStub
    }
    
}

