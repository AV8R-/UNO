//
//  LimitPicker.swift
//  Views
//
//  Created by Богдан Маншилин on 24/03/2018.
//  Copyright © 2018 BManshilin. All rights reserved.
//

import UIKit

final class LimitPicker: UIView {
    
    private weak var limit: UILabel!
    private weak var background: BackgroundView!
    
    init() {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .white
        layer.cornerRadius = 15
        
        let background = BackgroundView(
            color: .lightGreen,
            shadowColor: .darkGreen,
            cornerRadius: 20
        )
        background.isUserInteractionEnabled = false
        
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        title.text = NSLocalizedString("Limit", comment: "")
        title.font = .unoFont(forTextStyle: .title1)
        title.textColor = .lightGreen
        
        let limit = UILabel()
        limit.translatesAutoresizingMaskIntoConstraints = false
        limit.text = "500"
        limit.font = .unoFont(forTextStyle: .largeTitle)
        limit.textColor = .white
        limit.isUserInteractionEnabled = false
        
        addSubview(background)
        addSubview(title)
        addSubview(limit)
        
        NSLayoutConstraint.activate([
            background.topAnchor.constraint(equalTo: topAnchor, constant: 30),
            background.leftAnchor.constraint(equalTo: leftAnchor, constant: 10),
            background.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            background.rightAnchor.constraint(equalTo: rightAnchor, constant: -10),
            
            title.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 22),
            title.topAnchor.constraint(equalTo: topAnchor),
            title.bottomAnchor.constraint(equalTo: background.topAnchor),
            
            limit.centerXAnchor.constraint(equalTo: background.centerXAnchor),
            limit.centerYAnchor.constraint(equalTo: background.centerYAnchor),
        ])
        
        let gesture = UIPanGestureRecognizer(target: self, action: #selector(swipe(_:)))
        addGestureRecognizer(gesture)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(tap(_:)))
        addGestureRecognizer(tap)
        
        self.limit = limit
        self.background = background
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func swipe(_ sender: UIPanGestureRecognizer) {
        guard sender.numberOfTouches > 0 else {
            return
        }
        
        let value = Rescale(domain0: 0, domain1: Double(bounds.width), range0: 100, range1: 1000)
            .rescale(Double(sender.location(ofTouch: 0, in: self).x))
        
        limit.text = "\(Int(value) - Int(value) % 10)"
    }
    
    @objc func tap(_ sender: UITapGestureRecognizer) {
        if let text = limit.text, let num = Int(text), num == 500 {
            let bg = BackgroundView(color: .lightRed, shadowColor: .darkGray, cornerRadius: 15)
            let text = UILabel()
            text.translatesAutoresizingMaskIntoConstraints = false
            text.text = NSLocalizedString("Swipe", comment: "Hint on limit picker")
            text.font = .unoFont(forTextStyle: .title1)
            text.textColor = .white
            bg.alpha = 0
            text.alpha = 0
            
            addSubview(bg)
            addSubview(text)
            
            NSLayoutConstraint.activate([
                bg.leadingAnchor.constraint(equalTo: background.leadingAnchor),
                bg.topAnchor.constraint(equalTo: background.topAnchor),
                bg.rightAnchor.constraint(equalTo: background.rightAnchor),
                bg.bottomAnchor.constraint(equalTo: background.bottomAnchor),
                
                text.centerXAnchor.constraint(equalTo: bg.centerXAnchor),
                text.centerYAnchor.constraint(equalTo: bg.centerYAnchor),
            ])
            
            UIView.animate(withDuration: 0.3) {
                bg.alpha = 1
                text.alpha = 1
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [weak bg, weak text] in
                UIView.animate(withDuration: 0.3, animations: {
                    bg?.alpha = 0
                    text?.alpha = 0
                }, completion: { (finished) in
                    bg?.removeFromSuperview()
                    text?.removeFromSuperview()
                })
            }
        } else {
            limit.text = "500"
        }
    }
}
