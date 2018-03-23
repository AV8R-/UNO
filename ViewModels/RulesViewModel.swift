//
//  RulesViewModel.swift
//  ViewModels
//
//  Created by Богдан Маншилин on 23/03/2018.
//  Copyright © 2018 BManshilin. All rights reserved.
//

import Foundation
import Core_UI
import Model

public protocol ChooseRulesViewModelling {
    var io: ProgressedStepIO { get }
}

public final class ChooseRulesViewModel: ChooseRulesViewModelling, Step, ProgressedStepIO {
    public var io: ProgressedStepIO {
        return self
    }
    
    // Step props
    public typealias Input = Void
    public typealias Output = Rules

    public var input: Void?
    public var title: String { return NSLocalizedString("Rules", comment: "") }
    public var onShow: ((ChooseRulesViewModel) -> Void)?
    public var onFinish: ((Rules) -> Void)?
    public var currentOutput: Rules = .min(limit: 500)
    
    //Progressed step props
    public var onChangeCanGoNext: ((Bool) -> Void)?
    public var isCanGoNext: Bool = true
}
