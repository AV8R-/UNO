//
//  Step.swift
//  Core-UI
//
//  Created by Богдан Маншилин on 20/03/2018.
//  Copyright © 2018 BManshilin. All rights reserved.
//

import UIKit

protocol Step {
    associatedtype Input
    associatedtype Output
    
    var input: Input? { set get }
    var currentOutput: Output { get }
    var onFinish: ((Output) -> Void)? { set get }
    var onShow: ((Self) -> Void)? { set get }
}

protocol ProgressedStep {
    var view: UIView! { get }
    var io: ProgressedStepIO { get }
}

protocol ProgressedStepIO: class {
    var onChangeCanGoNext: ((Bool)->Void)? { set get }
    var isCanGoNext: Bool { get }
    var title: String { get }
    func finish()
    func didShow()
}

extension ProgressedStepIO where Self: Step {
    func finish() {
        onFinish?(currentOutput)
    }
    
    func didShow() {
        onShow?(self)
    }
}
