//
//  AddPlayersViewModel.swift
//  ViewModels
//
//  Created by Богдан Маншилин on 31/03/2018.
//  Copyright © 2018 BManshilin. All rights reserved.
//

import Foundation

public protocol AddPlayersViewModelling {
    var io: ProgressedStepIO { get }
}

public final class AddPlayersViewModel: AddPlayersViewModelling, Step, ProgressedStepIO {
    public var input: Rules?
    public var currentOutput: [Player] = []
    public var onFinish: (([Player]) -> Void)?
    public var onShow: ((AddPlayersViewModel) -> Void)?
    
    public var io: ProgressedStepIO {
        return self
    }
    
    public typealias Input = Rules
    public typealias Output = [Player]
    public var onChangeCanGoNext: ((Bool) -> Void)?
    public var isCanGoNext: Bool = false
    public var title: String = NSLocalizedString("PLAYERS", comment: "")
    
    let playersService: GameCreating
    
    init(playersService: GameCreating) {
        self.playersService = playersService
    }
    
}

