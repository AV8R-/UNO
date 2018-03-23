//
//  UNOButton.swift
//  Core-UI
//
//  Created by Богдан Маншилин on 23/03/2018.
//  Copyright © 2018 BManshilin. All rights reserved.
//

import Foundation

open class UNOButton: ComplexButton {
    
    public enum HighlightDirection {
        case grow, diminish
    }
    
    open var highlightDirection: HighlightDirection = .grow
    
    public init() {
        super.init(frame: .zero)
        shouldMakeTranclucentOnHiglhlight = false
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override open var isHighlighted: Bool { didSet {
        let isGrow = highlightDirection == .grow
        let scale: CGFloat = isGrow ? 1.05 : 0.95
        
        let animator = UIViewPropertyAnimator(
            duration: 0.05,
            curve: UIViewAnimationCurve.easeOut
        ) {
            self.transform = self.isHighlighted
                ? CGAffineTransform.identity.scaledBy(x: scale, y: scale)
                : CGAffineTransform.identity
            
            self.layer.shadowRadius = self.isHighlighted
                ? (isGrow ? 10 : 4)
                : (isGrow ? 4 : 10)
        }
        animator.startAnimation()
    }}
}
