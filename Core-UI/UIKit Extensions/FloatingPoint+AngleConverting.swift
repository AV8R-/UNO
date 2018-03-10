//
//  FloatingPoint+AngleConverting.swift
//  Core-UI
//
//  Created by Богдан Маншилин on 10/03/2018.
//  Copyright © 2018 BManshilin. All rights reserved.
//

import Foundation

extension FloatingPoint {
    func radiansToDegrees() -> Self {
        return self * 180 / Self.pi
    }
    
    func degreesToRadians() -> Self {
        return self * Self.pi / 180
    }
}
