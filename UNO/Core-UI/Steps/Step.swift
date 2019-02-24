//
//  Step.swift
//  Core-UI
//
//  Created by Богдан Маншилин on 20/03/2018.
//  Copyright © 2018 BManshilin. All rights reserved.
//

import UIKit

public protocol Step {
    associatedtype Input
    associatedtype Output
    
    var input: Input? { set get }
    var currentOutput: Output { get }
    var onFinish: ((Output) -> Void)? { set get }
    var onShow: ((Self) -> Void)? { set get }
}

public protocol ProgressedStep {
    var view: UIView! { get }
    var io: ProgressedStepIO { get }
}

public protocol ProgressedStepIO: class {
    var onChangeCanGoNext: ((Bool)->Void)? { set get }
    var isCanGoNext: Bool { get }
    var title: String { get }
    func finish()
    func didShow()
}

public extension ProgressedStepIO where Self: Step {
    public func finish() {
        onFinish?(currentOutput)
    }
    
    public func didShow() {
        onShow?(self)
    }
}
