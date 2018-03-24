//
//  LimitDescriptionView.swift
//  Views
//
//  Created by Богдан Маншилин on 24/03/2018.
//  Copyright © 2018 BManshilin. All rights reserved.
//

import UIKit
import Core_UI

final class LimitDescriptionView: UIView {
    
    var text: String {
        didSet {
            label.text = text
            label.runFade()
        }
    }
    
    private weak var label: UILabel!
    
    init(description: String) {
        self.text = description
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .white
        layer.cornerRadius = 15
        
        let background = BackgroundView(
            color: .lightGreen,
            shadowColor: .darkGreen,
            cornerRadius: 15
        )
        addSubview(background)
        
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = text
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .white
        label.font = .unoFont(forTextStyle: .body)
        addSubview(label)
        
        self.label = label
        
        NSLayoutConstraint.activate([
            background.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 6),
            background.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -6),
            background.topAnchor.constraint(equalTo: topAnchor, constant: 6),
            background.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -6),
            
            label.leadingAnchor.constraint(equalTo: background.leadingAnchor),
            label.trailingAnchor.constraint(equalTo: background.trailingAnchor),
            label.topAnchor.constraint(equalTo: background.topAnchor),
            label.bottomAnchor.constraint(equalTo: background.bottomAnchor),
        ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

final class BackgroundView: UIView {
    weak var shadowLayer: CALayer?
    let shadowColor: UIColor
    let shadowSide: UIView.ShadowSide
    let shadowSize: CGFloat
    
    init(
        color: UIColor,
        shadowColor: UIColor,
        cornerRadius: CGFloat,
        shadowSide: UIView.ShadowSide = [.top, .bottom],
        shadowSize: CGFloat = 4
        )
    {
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
