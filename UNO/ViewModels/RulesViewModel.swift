//
//  RulesViewModel.swift
//  ViewModels
//
//  Created by Богдан Маншилин on 23/03/2018.
//  Copyright © 2018 BManshilin. All rights reserved.
//

import Foundation

public protocol ChooseRulesViewModelling {
    var io: ProgressedStepIO { get }
    var currentDescription: String { get }
    var rules: Rules { set get }
    func setMaxRules() throws
    func setMinRules() throws
    
    var onRulesChange: ((Bool)->Void)? { set get }
}

public final class ChooseRulesViewModel: ChooseRulesViewModelling, Step, ProgressedStepIO {
    public var io: ProgressedStepIO {
        return self
    }
    
    public var currentDescription: String {
        return picker.description(for: currentOutput)
    }
    
    var picker: RulesPicking
    
    init(picker: RulesPicking) {
        self.picker = picker
    }
    
    public func setMaxRules() throws {
        rules = try .max(limit: rules.limit())
    }
    
    public func setMinRules() throws {
        rules = try .min(limit: rules.limit())
    }
    
    public var rules: Rules = .min(limit: 500) {
        didSet {
            onRulesChange?(oldValue != rules)
        }
    }
    
    public var onRulesChange: ((Bool) -> Void)?
    
    // Step props
    public typealias Input = Void
    public typealias Output = Rules

    public var input: Void?
    public var title: String { return NSLocalizedString("WIN SCORES", comment: "") }
    public var onShow: ((ChooseRulesViewModel) -> Void)?
    public var onFinish: ((Rules) -> Void)?
    public var currentOutput: Rules {
        return rules
    }
    
    //Progressed step props
    public var onChangeCanGoNext: ((Bool) -> Void)? {
        didSet {
            onChangeCanGoNext?(isCanGoNext)
        }
    }
    public var isCanGoNext: Bool = true
}
