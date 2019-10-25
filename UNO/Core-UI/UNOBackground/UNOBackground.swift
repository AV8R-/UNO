//
//  UNOBackground.swift
//  Core-UI
//
//  Created by Богдан Маншилин on 10/03/2018.
//  Copyright © 2018 BManshilin. All rights reserved.
//

import UIKit

public final class UNOBackground: UIView {
    
    @IBInspectable public var fromColor: UIColor = UIColor.lightRed
    @IBInspectable public var toColor: UIColor = UIColor.darkRed
    
    private var gradient: CALayer? {
        didSet {
            guard let gradient = gradient else {
                return
            }
            layer.insertSublayer(gradient, at: 0)
        }
    }
    
    private var beamsMask: CALayer? {
        didSet {
            beams?.layer.mask = beamsMask
        }
    }
    
    private var beams: UIView? {
        didSet {
            guard let beams = beams else {
                return
            }
            addSubview(beams)
            NSLayoutConstraint.activate([
                beams.leftAnchor.constraint(equalTo: leftAnchor),
                beams.topAnchor.constraint(equalTo: topAnchor),
                beams.bottomAnchor.constraint(equalTo: bottomAnchor),
                beams.rightAnchor.constraint(equalTo: rightAnchor),
                ])
        }
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        guard bounds != .zero else {
            return
        }
        
        let center = CGPoint(x: bounds.width/2, y: 80)
        let colors = [fromColor, toColor]
        
        self.beams = Beams(rotationCenter: center)
        
        let background: CALayer = RadialGradientBuilder()
            .center(center)
            .colors(colors)
            .startRadius(0)
            .endRadius(sqrt(pow(bounds.width - center.x, 2) + pow(bounds.height-center.y, 2)))
            .frame(bounds)
            .layer
        
        gradient = background
        
        let mask = RadialGradientBuilder()
            .center(center)
            .colors([.clear, .black])
            .startRadius(50)
            .endRadius(sqrt(pow(bounds.width - center.x, 2) + pow(bounds.height-center.y, 2)))
            .frame(bounds)
            .layer
        
        beamsMask = mask
    }
}
