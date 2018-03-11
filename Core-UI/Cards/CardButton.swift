//
//  CardButton.swift
//  Core-UI
//
//  Created by Богдан Маншилин on 10/03/2018.
//  Copyright © 2018 BManshilin. All rights reserved.
//

import UIKit
import AttributedTextView

public final class CardButton: ComplexButton {
    override public var isHighlighted: Bool { didSet {
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
    
    public init(background: UIImage, title: String) {
        super.init(frame: .zero)
        shouldMakeTranclucentOnHiglhlight = false
        
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowRadius = 4
        layer.shadowOffset = CGSize(width: 0, height: 4)
        layer.shadowOpacity = 0.6
        
        let bg = UIImageView(image: background)
        addSubview(bg)
        bg.translatesAutoresizingMaskIntoConstraints = false
        
        let title = title
            .white
            .strokeWidth(-1)
            .strokeColor(.black)
            .font(.unoFont(forTextStyle: .title1))
            .attributedText
        
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontForContentSizeCategory = true
        label.attributedText = title
        
        addSubview(label)
        
        NSLayoutConstraint.activate([
            bg.topAnchor.constraint(equalTo: topAnchor),
            bg.bottomAnchor.constraint(equalTo: bottomAnchor),
            bg.leftAnchor.constraint(equalTo: leftAnchor),
            bg.rightAnchor.constraint(equalTo: rightAnchor),
            
            label.centerXAnchor.constraint(equalTo: centerXAnchor),
            label.centerYAnchor.constraint(equalTo: centerYAnchor),
            ])

    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
