//
//  Arrow.swift
//  Views
//
//  Created by Богдан Маншилин on 24/03/2018.
//  Copyright © 2018 BManshilin. All rights reserved.
//

import UIKit

final class Arrow: UIView {
    init() {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        
        backgroundColor = .white
        
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: 9),
            widthAnchor.constraint(equalToConstant: 9),
        ])
        
        transform = CGAffineTransform.identity
            .rotated(by: CGFloat(45.0.degreesToRadians()))
            .concatenating(CGAffineTransform.identity.scaledBy(x: 1, y: 1.5))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
