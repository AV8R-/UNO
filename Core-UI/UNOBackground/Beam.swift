//
//  Beam.swift
//  Core-UI
//
//  Created by Богдан Маншилин on 10/03/2018.
//  Copyright © 2018 BManshilin. All rights reserved.
//

import UIKit

/**
 * Draws single beam. Beam is a long triangle with one very small angle like 2 degrees
 */
public final class Beam: CALayer {
    /// Color of the beam. Default is black with opacity 0.2
    var color = UIColor.black.withAlphaComponent(0.2).cgColor
    /// Angle of the beam in degrees. Default is 2.5
    var angle: CGFloat = 2.5
    
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
    
    public override func draw(in ctx: CGContext) {
        ctx.saveGState()
        let length = bounds.height
        
        let center = CGPoint(x: bounds.midX, y: 0)
        let ayAngle = angle.degreesToRadians()
        let axAngle = (90.0 - angle).degreesToRadians()
        
        let axCos = CGFloat(cos(axAngle))
        let ayCos = CGFloat(cos(ayAngle))
        
        let path = UIBezierPath()
        path.move(to: center)
        path.addLine(to: CGPoint(x: center.x - length * axCos, y: center.y + length * ayCos))
        path.addLine(to: CGPoint(x: center.x + length * axCos, y: center.y + length * ayCos))
        path.close()
        
        ctx.addPath(path.cgPath)
        ctx.setFillColor(color)
        ctx.fillPath()
    }
}

