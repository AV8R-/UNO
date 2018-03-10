//
//  UNOBackground.swift
//  Core-UI
//
//  Created by Богдан Маншилин on 10/03/2018.
//  Copyright © 2018 BManshilin. All rights reserved.
//

import UIKit

public final class UNOBackground: UIView {
    var colors = [
        UIColor(red: 255/255.0, green: 182/255.0, blue: 0, alpha: 1),
        UIColor(red: 236/255.0, green: 27/255.0, blue: 35/255.0, alpha: 1),
    ]
    
    var gradient: CALayer? {
        didSet {
            guard let gradient = gradient else {
                return
            }
            layer.insertSublayer(gradient, at: 0)
        }
    }
    var beamsMask: CALayer? {
        didSet {
            beams?.layer.mask = beamsMask
        }
    }
    var beams: UIView? {
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
