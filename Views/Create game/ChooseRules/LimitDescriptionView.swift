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
            cornerRadius: 20
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
            background.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            background.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            background.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            background.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            
            label.leadingAnchor.constraint(equalTo: background.leadingAnchor, constant: 30),
            label.trailingAnchor.constraint(equalTo: background.trailingAnchor, constant: -30),
            label.topAnchor.constraint(equalTo: background.topAnchor),
            label.bottomAnchor.constraint(equalTo: background.bottomAnchor),
        ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
