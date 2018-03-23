//
//  ChooseRules.swift
//  Views
//
//  Created by Богдан Маншилин on 23/03/2018.
//  Copyright © 2018 BManshilin. All rights reserved.
//

import Foundation
import Core_UI
import ViewModels

public protocol ChooseRulesViewControlling: ProgressedStep {}

final class ChooseRulesViewController: UIViewController, ChooseRulesViewControlling {
    var viewModel: ChooseRulesViewModelling
    var io: ProgressedStepIO
    
    public init(viewModel: ChooseRulesViewModelling, io: ProgressedStepIO) {
        self.io = io
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override public func loadView() {
        let view = UIView()
        view.backgroundColor = .clear
        
        let b1 = RulesButton(title: NSLocalizedString("MAX", comment: ""))
        let b2 = RulesButton(title: NSLocalizedString("MIN", comment: ""))
        let limitView = UIView()
        let hintView = UIView()
        limitView.backgroundColor = .red
        hintView.backgroundColor = .cyan
        
        b1.translatesAutoresizingMaskIntoConstraints = false
        b2.translatesAutoresizingMaskIntoConstraints = false
        limitView.translatesAutoresizingMaskIntoConstraints = false
        hintView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(b1)
        view.addSubview(b2)
        view.addSubview(limitView)
        view.addSubview(hintView)
        
        NSLayoutConstraint.activate([
            b1.widthAnchor.constraint(equalTo: b2.widthAnchor),
            b1.heightAnchor.constraint(equalTo: b2.heightAnchor),
            b1.topAnchor.constraint(equalTo: b2.topAnchor),
            b1.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            b1.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            b2.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            b1.heightAnchor.constraint(equalToConstant: 149),
            b1.trailingAnchor.constraint(equalTo: b2.leadingAnchor, constant: -14),
            
            limitView.heightAnchor.constraint(equalToConstant: 114),
            limitView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            limitView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            limitView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            hintView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            hintView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            hintView.topAnchor.constraint(equalTo: b1.bottomAnchor, constant: 12),
            hintView.bottomAnchor.constraint(equalTo: limitView.topAnchor, constant: -12),
            ])
        
        self.view = view
    }
}

final class RulesButton: UNOButton {
    init(title: String) {
        super.init()
        
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
