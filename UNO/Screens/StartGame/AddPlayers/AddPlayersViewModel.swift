import Foundation
import Bond

enum AddPlayerViewModelError: Error {
    case playerAlreadyExist
    case playerNameShouldNotBeEmpty
}

public final class AddPlayersViewModel: Step, ProgressedStepIO {
    typealias Input = Rules
    typealias Output = [Player]

    var input: Rules?
    var currentOutput: [Player] {
        return players.array
    }
    let players = MutableObservableArray<Player>()

    var onFinish: (([Player]) -> Void)?
    var onShow: ((AddPlayersViewModel) -> Void)?

    var onChangeCanGoNext: ((Bool) -> Void)?
    var isCanGoNext: Bool = false
    var title: String = NSLocalizedString("PLAYERS", comment: "")
    
    let playersService: GameCreating
    
    init(playersService: GameCreating) {
        self.playersService = playersService
    }

    func appendPlayer(name: String) throws {
        do {
            let player = try Player(name: name)
            guard !players.array.contains(player) else {
                throw AddPlayerViewModelError.playerAlreadyExist
            }
            
            players.append(player)
        } catch is ValidationError {
            throw AddPlayerViewModelError.playerNameShouldNotBeEmpty
        } catch {
            throw error
        }
    }
    
    func removePlayer(_ player: Player) {
        guard let index = players.array.firstIndex(of: player) else {
            return
        }
        
        players.remove(at: index)

    }
    
    func startGame() {
    }
}


