//
//  UNOButton.swift
//  Core-UI
//
//  Created by Богдан Маншилин on 23/03/2018.
//  Copyright © 2018 BManshilin. All rights reserved.
//

import Foundation

open class UNOButton: ComplexButton {
    
    public init() {
        super.init(frame: .zero)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override open var isHighlighted: Bool { didSet {
        let animator = UIViewPropertyAnimator(
            duration: 0.05,
            curve: UIViewAnimationCurve.easeOut
        ) {
            self.transform = self.isHighlighted
                ? CGAffineTransform.identity.scaledBy(x: 1.05, y: 1.05)
                : CGAffineTransform.identity
            
            self.layer.shadowRadius = self.isHighlighted
                ? 10
                : 4
        }
        animator.startAnimation()
    }}
}
