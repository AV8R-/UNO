//
//  RulesButton.swift
//  Views
//
//  Created by Богдан Маншилин on 24/03/2018.
//  Copyright © 2018 BManshilin. All rights reserved.
//

import Foundation
import Core_UI

final class RulesButton: UNOButton {
    init(title: String) {
        super.init()
        translatesAutoresizingMaskIntoConstraints = false
        
        highlightDirection = .diminish
        
        backgroundColor = .white
        layer.cornerRadius = 15
        
        let background = UIView()
        background.translatesAutoresizingMaskIntoConstraints = false
        background.backgroundColor = UIColor.lightGreen
        background.layer.cornerRadius = 20
        addSubview(background)
        
        let titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = title
        titleLabel.font = UIFont.unoFont(forTextStyle: .largeTitle)
        titleLabel.textColor = .white
        addSubview(titleLabel)
        
        let overlayMask = UIView()
        overlayMask.translatesAutoresizingMaskIntoConstraints = false
        overlayMask.layer.cornerRadius = 20
        overlayMask.clipsToBounds = true
        addSubview(overlayMask)
        
        let darkOverlay = UIView()
        darkOverlay.translatesAutoresizingMaskIntoConstraints = false
        darkOverlay.backgroundColor = UIColor.darkGreen.withAlphaComponent(0.7)
        darkOverlay.transform = CGAffineTransform.identity
            .rotated(by: CGFloat(-7.0.degreesToRadians()))
        overlayMask.addSubview(darkOverlay)
        
        NSLayoutConstraint.activate([
            background.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            background.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            background.topAnchor.constraint(equalTo: topAnchor, constant: 6),
            background.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -6),
            
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            overlayMask.leadingAnchor.constraint(equalTo: background.leadingAnchor),
            overlayMask.trailingAnchor.constraint(equalTo: background.trailingAnchor),
            overlayMask.topAnchor.constraint(equalTo: background.topAnchor),
            overlayMask.bottomAnchor.constraint(equalTo: background.bottomAnchor),
            
            darkOverlay.widthAnchor.constraint(equalTo: overlayMask.widthAnchor, multiplier: 2),
            darkOverlay.heightAnchor.constraint(equalTo: overlayMask.heightAnchor, multiplier: 0.95),
            darkOverlay.centerYAnchor.constraint(equalTo: overlayMask.bottomAnchor),
            darkOverlay.centerXAnchor.constraint(equalTo: overlayMask.centerXAnchor),
            ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
