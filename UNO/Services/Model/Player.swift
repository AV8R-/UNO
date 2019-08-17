//
//  Player.swift
//  UNO
//
//  Created by Богдан Маншилин on 09/02/2018.
//  Copyright © 2018 BManshilin. All rights reserved.
//

import Foundation

public struct Player: Equatable {
    public var name: String
    
    public init(name: String) throws {
        guard name.count > 0 else {
            throw ValidationError.invalid(
                field: "name",
                ofType: String.self,
                onObjectOfType: Player.self,
                reason: "Name can not be empty"
            )
        }
        
        self.name = name
    }
}
