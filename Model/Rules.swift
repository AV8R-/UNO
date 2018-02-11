//
//  Rules.swift
//  Model
//
//  Created by Богдан Маншилин on 11/02/2018.
//  Copyright © 2018 BManshilin. All rights reserved.
//

import Foundation

public enum Rules {
    case min(limit: Int)
    case max(limit: Int)
    
    public static func validMin(limit: Int) throws -> Rules {
        try validate(limit: limit)
        return .min(limit: limit)
    }
    
    public static func validMax(limit: Int) throws -> Rules {
        try validate(limit: limit)
        return .max(limit: limit)
    }
    
    private static func validate(limit: Int) throws {
        guard 0..<10_000 ~= limit else {
            throw ValidationError.invalid(
                field: "limit",
                ofType: Int.self,
                onObjectOfType: Rules.self,
                reason: "Limit must bu in range of 0..<10_000"
            )
        }
    }
    
    /// Get limit of the scores
    ///
    /// Throws error of type `ValidationError`
    public func limit() throws -> Int {
        switch self {
        case .min(limit: let limit):
            try Rules.validate(limit: limit)
            return limit
        case .max(limit: let limit):
            try Rules.validate(limit: limit)
            return limit
        }
    }
}
