//
//  LimitDescriptionView.swift
//  Views
//
//  Created by Богдан Маншилин on 24/03/2018.
//  Copyright © 2018 BManshilin. All rights reserved.
//

import UIKit

final class LimitDescriptionView: UIView {
    
    init(description: String) {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .white
        layer.cornerRadius = 15
        
        let background = UIView()
        background.translatesAutoresizingMaskIntoConstraints = false
        background.backgroundColor = .lightGreen
        background.layer.cornerRadius = 20
        addSubview(background)
        
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = description
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .white
        label.font = .unoFont(forTextStyle: .body)
        addSubview(label)
        
        NSLayoutConstraint.activate([
            background.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            background.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
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
