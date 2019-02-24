//
//  UIView+InnerShadow.swift
//  Core-UI
//
//  Created by Богдан Маншилин on 24/03/2018.
//  Copyright © 2018 BManshilin. All rights reserved.
//

import UIKit

extension UIView {
    
    public struct ShadowSide: OptionSet {
        public let rawValue: Int
        
        public init(rawValue: Int) {
            self.rawValue = rawValue
        }
        
        public static let left = ShadowSide(rawValue: 1 << 0)
        public static let right = ShadowSide(rawValue: 1 << 1)
        public static let top = ShadowSide(rawValue: 1 << 2)
        public static let bottom = ShadowSide(rawValue: 1 << 3)
        
        public static let all: ShadowSide = [.left, .right, .top, .bottom]
    }
    
    // define function to add inner shadow
    public func addInnerShadow(
        onSide side: ShadowSide,
        color: UIColor,
        size: CGFloat,
        cornerRadius: CGFloat = 0.0,
        opacity: Float
        )
    {
        layer.masksToBounds = true
        let shadowLayer = CAShapeLayer()
        shadowLayer.frame = bounds;
        
        // Standard shadow stuff
        shadowLayer.shadowColor = color.cgColor
        shadowLayer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        shadowLayer.shadowOpacity = opacity
        shadowLayer.shadowRadius = size
        
        // Causes the inner region in this example to NOT be filled.
        shadowLayer.fillRule = kCAFillRuleEvenOdd
        
        // Create the larger rectangle path.
        let path = CGMutablePath()
        path.addRect(bounds.insetBy(dx: -size * 2, dy: -size * 2))
        
        let innerFrame: CGRect = { () -> CGRect in
            let x: CGFloat = side.contains(.left) ? 0 : -size
            let y: CGFloat = side.contains(.top) ? 0 : -size
            let width: CGFloat = side.contains(.right) ? bounds.width - x : bounds.width - x + size
            let height: CGFloat = side.contains(.bottom) ? bounds.height - y : bounds.height - y + size
            
            return CGRect(x: x, y: y, width: width, height: height)
        }()
        
        // Add the inner path so it's subtracted from the outer path.
        // someInnerPath could be a simple bounds rect, or maybe
        // a rounded one for some extra fanciness.
        let someInnerPath = UIBezierPath(roundedRect: innerFrame, cornerRadius: cornerRadius).cgPath
        path.addPath(someInnerPath)
        path.closeSubpath()
        
        shadowLayer.path = path
        
        layer.addSublayer(shadowLayer)
    }
}
