import Foundation
import Quick
import Nimble
@testable import UNO

final class AddPlayersViewModelSpec: QuickSpec {

    
    override func spec() {
        var viewModel: AddPlayersViewModel!
        var gameCreatingMock: GameCreatingMock!
        
        beforeEach {
            gameCreatingMock = GameCreatingMock()
            viewModel = AddPlayersViewModel(playersService: gameCreatingMock)
        }
        
        describe(".appendPlayer(name:)") {
            it("should not append empty name") {
                let playerName = ""
                
                expect {
                    try viewModel.appendPlayer(name: playerName)
                }.to(throwError(AddPlayerViewModelError.playerNameShouldNotBeEmpty))
            }
        }
        
    }
}

