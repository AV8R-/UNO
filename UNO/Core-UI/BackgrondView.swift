//
//  BackgrondView.swift
//  Views
//
//  Created by Богдан Маншилин on 01/04/2018.
//  Copyright © 2018 BManshilin. All rights reserved.
//

import UIKit

final class BackgroundView: UIView {
    private weak var shadowLayer: CALayer?
    var shadowColor: UIColor
    var shadowSide: UIView.ShadowSide
    var shadowSize: CGFloat
    
    init(
        color: UIColor = .clear,
        shadowColor: UIColor = .clear,
        cornerRadius: CGFloat = 0,
        shadowSide: UIView.ShadowSide = [.top, .bottom],
        shadowSize: CGFloat = 4
    ) {
        self.shadowSide = shadowSide
        self.shadowSize = shadowSize
        self.shadowColor = shadowColor
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = color
        layer.cornerRadius = cornerRadius
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var bounds: CGRect {
        didSet {
            addInnerShadow(onSide: shadowSide, color: shadowColor, size: shadowSize, cornerRadius: layer.cornerRadius, opacity: 1)
        }
    }
}
