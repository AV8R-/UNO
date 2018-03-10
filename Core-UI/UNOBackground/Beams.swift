//
//  Beams.swift
//  Core-UI
//
//  Created by Богдан Маншилин on 10/03/2018.
//  Copyright © 2018 BManshilin. All rights reserved.
//

import UIKit

/**
 * Layer with many beams drawed radially around some point
 */
public final class Beams: UIView {
    
    private var isDrawn = false
    
    /// Angle in radians in the top of the layer wich will be free of beams.
    /// Default is .pi/1.65
    var deadZone: CGFloat = .pi/1.65
    /// Cont of beams to draw. Default is 13
    var beamsCount = 13
    /// The point around wich beams are drawn
    let rotationPoint: CGPoint
    
    /// - Parameter rotationCenter: the point around wich beams are rotated
    convenience init(rotationCenter: CGPoint) {
        self.init(rotationCenter: rotationCenter, frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .clear
    }
    
    public init(rotationCenter: CGPoint, frame: CGRect) {
        self.rotationPoint = rotationCenter
        super.init(frame: frame)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func draw(_ rect: CGRect) {
        guard !isDrawn else {
            return
        }
        isDrawn = true
        
        var startPoint = rotationPoint
        startPoint.x = startPoint.x - 30
        let beamSize = CGSize(width: 60, height: rect.height)
        
        for i in 0...beamsCount {
            let currentBeam = CGFloat(i)
            let beam = Beam()
            beam.frame = CGRect(origin: startPoint, size: beamSize)
            
            let rotationAngle = (2 * .pi - deadZone) / CGFloat(beamsCount)
            let startAngle: CGFloat = .pi - deadZone/2
            let angle = startAngle - currentBeam * rotationAngle
            
            var transform = CATransform3DIdentity
            transform = CATransform3DTranslate(transform, rotationPoint.x-beam.position.x, rotationPoint.y-beam.position.y, 0)
            transform = CATransform3DRotate(transform, angle, 0, 0, 1)
            transform = CATransform3DTranslate(transform, beam.position.x-rotationPoint.x, beam.position.y-rotationPoint.y, 0)
            
            beam.transform = transform
            
            layer.addSublayer(beam)
            
        }
    }
}

