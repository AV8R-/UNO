//
//  FloatingPoint+AngleConverting.swift
//  Core-UI
//
//  Created by Богдан Маншилин on 10/03/2018.
//  Copyright © 2018 BManshilin. All rights reserved.
//

import Foundation

extension FloatingPoint {
    public func radiansToDegrees() -> Self {
        return self * 180 / Self.pi
    }
    
    public func degreesToRadians() -> Self {
        return self * Self.pi / 180
    }
}
