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
            it("should throw when appending empty name") {
                let playerName = ""
                
                expect {
                    try viewModel.appendPlayer(name: playerName)
                }.to(throwError(AddPlayerViewModelError.playerNameShouldNotBeEmpty))
            }
            
            it("should throw when appending existing name") {
                let player = Stubs.player1

                viewModel.players.append(player)
                
                expect {
                    try viewModel.appendPlayer(name: player.name)
                }.to(throwError(AddPlayerViewModelError.playerAlreadyExist))
            }
            
            it("should append valid player") {
                let player = Stubs.player1
                
                expect {
                    try viewModel.appendPlayer(name: player.name)
                }.toNot(throwError())
                
                expect(viewModel.players.array).to(contain(player))
            }
        }
        
    }
}

