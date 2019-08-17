import Foundation
@testable import UNO

enum Stubs {
    static let game = try! Calculator(rules: .max(limit: 500), players: [player1, player2, player3])
    
    static let player1 = try! Player(name: "John")
    static let player2 = try! Player(name: "Mad")
    static let player3 = try! Player(name: "Doe")
}
