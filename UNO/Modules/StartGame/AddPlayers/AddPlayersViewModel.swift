import Foundation
import Bond

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

    func didEnter(text: String) {
        do {
            players.append(try Player(name: text))
        } catch {
//            view.showError(error)
        }
    }
}


