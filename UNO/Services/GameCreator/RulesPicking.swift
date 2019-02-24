//
//  RulesPicker.swift
//  Services
//
//  Created by Богдан Маншилин on 12/02/2018.
//  Copyright © 2018 BManshilin. All rights reserved.
//

import Foundation

/// Service for picking rules
public protocol RulesPicking {
    /// Get localized description for specified rules type
    func description(for: Rules) -> String
    
    /// Choose the rules for the game
    mutating func set(rules: Rules)
    
    /// Set new scores limit
    ///
    /// Thorws error of type `Model.ValidationError`
    mutating func set(limit: Int) throws
    
    /// Chosen rules. Default value is `.min(limit: 500)`
    var currentRules: Rules { get }
}
