//
//  RulesPicker.swift
//  Services
//
//  Created by Богдан Маншилин on 23/03/2018.
//  Copyright © 2018 BManshilin. All rights reserved.
//

import Foundation

struct RulesPicker: RulesPicking {
    func description(for rules: Rules) -> String {
        switch rules {
        case .max:
            return NSLocalizedString(
                """
                Wins player that first reached score limit.
                The winner of the round collect scores of all players.
                """,
                comment: ""
            )
        case .min:
            return NSLocalizedString(
                """
                Loses player that first reached score limit.
                Wins player with least scores.
                The winner of the round gets no scores.
                """,
                comment: ""
            )
        }
    }
    private(set) var currentRules: Rules = .min(limit: 500)
    
    mutating func set(limit: Int) throws {
        try currentRules.set(limit: limit)
    }
    
    mutating func set(rules: Rules) {
        currentRules = rules
    }
}
