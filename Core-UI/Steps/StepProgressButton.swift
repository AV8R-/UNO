//
//  StepProgressButton.swift
//  Core-UI
//
//  Created by Богдан Маншилин on 20/03/2018.
//  Copyright © 2018 BManshilin. All rights reserved.
//

import UIKit

class StepProgressButton: ComplexButton {
    enum Kind {
        case back
        case forward(selectedColor: UIColor)
        case page(num: Int, color: UIColor, selectedColor: UIColor)
        
        var color: UIColor {
            if case .page(_, let color, _) = self  { return color }
            else                             { return .clear }
        }
        
        var selectedColor: UIColor {
            if case .page(_, _, let color) = self      { return color }
            else if case .forward(let color) = self { return color }
            else                                    { return .clear }
        }
        
        var size: CGSize {
            return CGSize(width: 50, height: 50)
        }
        
        var selectedSize: CGSize {
            if case .forward = self {
                return CGSize(width: 100, height: size.height)
            } else {
                return size
            }
        }
        
        func content(frame: CGRect, isSelected: Bool) -> CALayer {
            switch self {
            case .forward where isSelected:
                let content = CATextLayer()
                content.frame = CGRect(
                    origin: CGPoint(x: 0, y: frame.size.height/2 - 15),
                    size: frame.size
                )
                content.string = "START"
                content.fontSize = UIFont.prefferedFontSize(forTextStyle: .title1)
                content.alignmentMode = kCAAlignmentCenter
                content.font = UIFont.unoFont(forTextStyle: .title1)
                
                return content
            case .back, .forward:
                let content = CAShapeLayer()
                content.frame = frame
                content.path = path(forRect: frame, isSelected: isSelected)
                content.strokeColor = UIColor.white.cgColor
                content.fillColor = UIColor.clear.cgColor
                content.lineWidth = 4
                content.lineCap = kCALineCapRound
                
                return content
            case .page(let num, let color, let selectedColor):
                let content = CATextLayer()
                var frame = frame
                frame.origin.y -= 2
                content.frame = frame
                content.string = "\(num)"
                content.fontSize = UIFont.prefferedFontSize(forTextStyle: .title1)
                content.alignmentMode = kCAAlignmentCenter
                content.font = UIFont.unoFont(forTextStyle: .title1)
                content.foregroundColor = isSelected
                    ? color.cgColor
                    : selectedColor.cgColor
                
                return content
            }
        }
        
        private func path(forRect rect: CGRect, isSelected: Bool) -> CGPath? {
            switch self {
            case .back:
                return isSelected ?  cross(in: rect) : arrow(in: rect)
            case .forward where !isSelected:
                return arrow(
                    in: rect,
                    transform: CGAffineTransform
                        .identity
                        .scaledBy(x: -1, y: 1)
                        .concatenating(
                            CGAffineTransform(translationX: rect.width, y: 0)
                    )
                )
            default:
                return nil
            }
        }
        
        private func cross(in rect: CGRect) -> CGPath {
            let a = rect.width / sqrt(2)
            let rect = CGRect(x: rect.width/2 - a/2, y: rect.height/2 - a/2, width: a, height: a)
            
            
            let path = CGMutablePath()
            path.move(to: CGPoint(x: rect.origin.x, y: rect.origin.y))
            path.addLine(to: CGPoint(x: rect.origin.x + rect.width, y: rect.origin.y + rect.height))
            path.move(to: CGPoint(x: rect.origin.x, y: rect.origin.y + rect.height))
            path.addLine(to: CGPoint(x: rect.origin.x + rect.width, y: rect.origin.y))
            return path
        }
        
        private func arrow(in rect: CGRect, transform: CGAffineTransform = .identity) -> CGPath {
            let path = CGMutablePath()
            path.move(to: CGPoint(x: rect.width, y: rect.height/2), transform: transform)
            path.addLine(to: CGPoint(x: 0, y: rect.height/2), transform: transform)
            path.move(to: CGPoint(x: rect.width * 3/8, y: rect.height * 2/8), transform: transform)
            path.addLine(to: CGPoint(x: 0, y: rect.height/2), transform: transform)
            path.move(to: CGPoint(x: rect.width * 3/8, y: rect.height * 6/8), transform: transform)
            path.addLine(to: CGPoint(x: 0, y: rect.height/2), transform: transform)
            return path
        }
    }
    
    private var content: CALayer?
    private var kind: Kind
    private weak var disabledOverlay: UIView?
    private var width: NSLayoutConstraint!
    private var height: NSLayoutConstraint!
    
    init(kind: Kind) {
        self.kind = kind
        super.init(frame: .zero)
        layer.borderColor = UIColor.white.cgColor
        layer.borderWidth = 5
        shouldMakeTranclucentOnHiglhlight = false
        backgroundColor = kind.color
        layer.masksToBounds = true
        translatesAutoresizingMaskIntoConstraints = false
        
        width = widthAnchor.constraint(equalToConstant: kind.size.width)
        height = heightAnchor.constraint(equalToConstant: kind.size.height)
        
        width.isActive = true
        height.isActive = true
    }
    
    override var isHighlighted: Bool {
        didSet {
            transform = isHighlighted
                ? CGAffineTransform.identity.scaledBy(x: 0.95, y: 0.95)
                : CGAffineTransform.identity
        }
    }
    
    override var isSelected: Bool {
        didSet {
            backgroundColor = isSelected
                ? kind.selectedColor
                : kind.color
            
            let size = isSelected ? kind.selectedSize : kind.size
            width.constant = size.width
            height.constant = size.height
            
            UIView.animate(withDuration: 0.1, animations: layoutIfNeeded)
        }
    }
    
    override var isEnabled: Bool {
        didSet {
            if isEnabled {
                disabledOverlay?.removeFromSuperview()
                disabledOverlay = nil
            } else if disabledOverlay == nil {
                let overlay = UIView(frame: bounds)
                overlay.translatesAutoresizingMaskIntoConstraints = false
                overlay.backgroundColor = UIColor.black.withAlphaComponent(0.7)
                addSubview(overlay)
                disabledOverlay = overlay
                
                NSLayoutConstraint.activate([
                    overlay.leadingAnchor.constraint(equalTo: leadingAnchor),
                    overlay.trailingAnchor.constraint(equalTo: trailingAnchor),
                    overlay.topAnchor.constraint(equalTo: topAnchor),
                    overlay.bottomAnchor.constraint(equalTo: bottomAnchor),
                    ])
            }
        }
    }
    
    override var bounds: CGRect {
        didSet {
            layer.cornerRadius = bounds.height/2
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        if let content = content {
            content.removeFromSuperlayer()
            self.content = nil
        }
        
        if rect.width == rect.height {
            let a = rect.width / sqrt(2) - 10
            let newRect = CGRect(x: rect.width/2-a/2, y: rect.width/2-a/2, width: a, height: a)
            
            content = kind.content(frame: newRect, isSelected: isSelected)
        } else {
            content = kind.content(frame: rect, isSelected: isSelected)
        }
        
        layer.addSublayer(content!)
    }
}
