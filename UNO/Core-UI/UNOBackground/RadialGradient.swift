//
//  RadialGradient.swift
//  Core-UI
//
//  Created by Богдан Маншилин on 10/03/2018.
//  Copyright © 2018 BManshilin. All rights reserved.
//

import UIKit

/// Layer with configured radial gradient
public final class RadialGradientLayer: CALayer {
    
    /// Center of the gradient
    public var center: CGPoint = .zero
    /// Colors of the gradient. First is inner, last is outter
    public var colors = [UIColor.black, UIColor.blue]
    /// Radius from wich gradient is to be started
    public var startRadius: CGFloat = 0
    /// Radius to wich gradient to be ended
    public var endRadius: CGFloat = 100
    
    required override public init() {
        super.init()
        needsDisplayOnBoundsChange = true
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    required override public init(layer: Any) {
        super.init(layer: layer)
    }
    
    override public func draw(in ctx: CGContext) {
        ctx.saveGState()
        let colors = self.colors.map { $0.cgColor }
        
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        var locations = [CGFloat]()
        for i in 0...colors.count-1 {
            locations.append(CGFloat(i) / CGFloat(colors.count))
        }
        let gradient = CGGradient(colorsSpace: colorSpace, colors: colors as CFArray, locations: locations)
        ctx.drawRadialGradient(
            gradient!,
            startCenter: center,
            startRadius: startRadius,
            endCenter: center,
            endRadius: endRadius,
            options: CGGradientDrawingOptions(rawValue: 0)
        )
    }
}
