//
//  RadialGradientBuilder.swift
//  Core-UI
//
//  Created by Богдан Маншилин on 10/03/2018.
//  Copyright © 2018 BManshilin. All rights reserved.
//

import UIKit

class RadialGradientBuilder {
    private var gradient: RadialGradientLayer
    
    var layer: CALayer {
        UIGraphicsBeginImageContext(gradient.bounds.size)
        gradient.draw(in: UIGraphicsGetCurrentContext()!)
        UIGraphicsEndImageContext()
        return gradient
    }
    
    init() {
        gradient = RadialGradientLayer()
    }
    
    func center(_ center: CGPoint) -> RadialGradientBuilder {
        gradient.center = center
        return self
    }
    
    func colors(_ colors: [UIColor]) -> RadialGradientBuilder {
        gradient.colors = colors
        return self
    }
    
    func startRadius(_ startRadius: CGFloat) -> RadialGradientBuilder {
        gradient.startRadius = startRadius
        return self
    }
    
    func endRadius(_ endRadius: CGFloat) -> RadialGradientBuilder {
        gradient.endRadius = endRadius
        return self
    }
    
    func frame(_ frame: CGRect) -> RadialGradientBuilder {
        gradient.frame = frame
        return self
    }
}
