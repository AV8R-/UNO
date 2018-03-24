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
    
    private var arrowLeftPosition: NSLayoutConstraint!
    private var arrowRightPosition: NSLayoutConstraint!
    private weak var hintView: LimitDescriptionView!
    
    public init(viewModel: ChooseRulesViewModelling, io: ProgressedStepIO) {
        self.io = io
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        
        self.viewModel.onRulesChange = { [weak self] isChanged in
            guard isChanged, let this = self else {
                return
            }
            let p1 = CGPoint(x: 0.25, y: 0.46)
            let p2 = CGPoint(x: 0.45, y: 0.94)
            let isMax: Bool, isMin: Bool
            if case .max = this.viewModel.rules {
                isMax = true; isMin = false
            } else {
                isMin = true; isMax = false
            }
            this.arrowLeftPosition.isActive = isMax
            this.arrowRightPosition.isActive = isMin
            
            UIViewPropertyAnimator(duration: 0.2, controlPoint1: p1, controlPoint2: p2, animations: this.view.layoutIfNeeded).startAnimation()
            this.hintView.text = this.viewModel.currentDescription
        }
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override public func loadView() {
        let view = UIView()
        view.backgroundColor = .clear
        
        let b1 = RulesButton(title: NSLocalizedString("MAX", comment: ""))
        let b2 = RulesButton(title: NSLocalizedString("MIN", comment: ""))
        let limitView = LimitPicker()
        let hintView = LimitDescriptionView(description: viewModel.currentDescription)
        let arrow = Arrow()
            
        view.addSubview(b1)
        view.addSubview(b2)
        view.addSubview(limitView)
        view.addSubview(arrow)
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
            
            arrow.bottomAnchor.constraint(equalTo: hintView.topAnchor, constant: 5),
        ])
        
        arrowLeftPosition = arrow.centerXAnchor.constraint(equalTo: b1.centerXAnchor)
        arrowRightPosition = arrow.centerXAnchor.constraint(equalTo: b2.centerXAnchor)
        
        arrowRightPosition.isActive = true
        
        self.view = view
        self.hintView = hintView
        
        b1.onPress = { [weak self] in
            try? self?.viewModel.setMaxRules()
        }
        
        b2.onPress = { [weak self] in
            try? self?.viewModel.setMinRules()
        }
    }
    
}
