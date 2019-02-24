import Foundation

public final class AddPlayersViewModel: Step, ProgressedStepIO {
    typealias Input = Rules
    typealias Output = [Player]

    var input: Rules?
    var currentOutput: [Player] = []

    var onFinish: (([Player]) -> Void)?
    var onShow: ((AddPlayersViewModel) -> Void)?

    var onChangeCanGoNext: ((Bool) -> Void)?
    var isCanGoNext: Bool = false
    var title: String = NSLocalizedString("PLAYERS", comment: "")
    
    let playersService: GameCreating
    
    init(playersService: GameCreating) {
        self.playersService = playersService
    }
    
}

