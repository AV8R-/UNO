//
//  UNOButton.swift
//  Core-UI
//
//  Created by Богдан Маншилин on 23/03/2018.
//  Copyright © 2018 BManshilin. All rights reserved.
//

import UIKit

open class UNOButton: ComplexButton {
    
    public enum HighlightDirection: Int {
        case grow, diminish
    }
    
    @IBInspectable var highlightDirection: Int = HighlightDirection.grow.rawValue
    
    public init(touchDirection: HighlightDirection = .grow) {
        self.highlightDirection = touchDirection.rawValue
        super.init(frame: .zero)
        shouldMakeTranclucentOnHiglhlight = false
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        shouldMakeTranclucentOnHiglhlight = false
    }
    
    open override func awakeFromNib() {
        super.awakeFromNib()
        shouldMakeTranclucentOnHiglhlight = false
    }
    
    override open var isHighlighted: Bool { didSet {
        let isGrow = highlightDirection == HighlightDirection.grow.rawValue
        let scale: CGFloat = isGrow ? 1.05 : 0.95
        
        let animator = UIViewPropertyAnimator(
            duration: 0.05,
            curve: UIView.AnimationCurve.easeOut
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
