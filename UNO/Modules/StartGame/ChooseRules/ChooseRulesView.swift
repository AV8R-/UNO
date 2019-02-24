//
//  ChooseRules.swift
//  Views
//
//  Created by Богдан Маншилин on 23/03/2018.
//  Copyright © 2018 BManshilin. All rights reserved.
//

import UIKit

final class ChooseRulesView: UIView, ProgressedStep {
    var viewModel: ChooseRulesViewModel
    var io: ProgressedStepIO {
         return viewModel
    }
    var view: UIView! {
        return self
    }
    
    private var arrowLeftPosition: NSLayoutConstraint!
    private var arrowRightPosition: NSLayoutConstraint!
    private weak var hintView: LimitDescriptionView!
    
    public init(viewModel: ChooseRulesViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
                
        self.viewModel.onRulesChange = { [weak self] isChanged in
            guard isChanged, let self = self else {
                return
            }

            let p1 = CGPoint(x: 0.25, y: 0.46)
            let p2 = CGPoint(x: 0.45, y: 0.94)
            let isMax: Bool, isMin: Bool
            if case .max = self.viewModel.rules {
                isMax = true; isMin = false
            } else {
                isMin = true; isMax = false
            }
            self.arrowLeftPosition.isActive = isMax
            self.arrowRightPosition.isActive = isMin
            
            UIViewPropertyAnimator(
                duration: 0.2,
                controlPoint1: p1,
                controlPoint2: p2,
                animations: self.view.layoutIfNeeded
            ).startAnimation()

            self.hintView.text = self.viewModel.currentDescription
        }
        
        loadView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func loadView() {
        backgroundColor = .clear
        
        let b1 = RulesButton(title: NSLocalizedString("MAX", comment: ""))
        let b2 = RulesButton(title: NSLocalizedString("MIN", comment: ""))
        let limitView = LimitPicker()
        let hintView = LimitDescriptionView(description: viewModel.currentDescription)
        let arrow = Arrow()
            
        addSubview(b1)
        addSubview(b2)
        addSubview(limitView)
        addSubview(arrow)
        addSubview(hintView)
        
        NSLayoutConstraint.activate([
            b1.widthAnchor.constraint(equalTo: b2.widthAnchor),
            b1.heightAnchor.constraint(equalTo: b2.heightAnchor),
            b1.topAnchor.constraint(equalTo: b2.topAnchor),
            b1.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            b1.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20),
            b2.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20),
            b1.heightAnchor.constraint(equalToConstant: 149),
            b1.trailingAnchor.constraint(equalTo: b2.leadingAnchor, constant: -14),
            
            limitView.heightAnchor.constraint(equalToConstant: 114),
            limitView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20),
            limitView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20),
            limitView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            
            hintView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20),
            hintView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20),
            hintView.topAnchor.constraint(equalTo: b1.bottomAnchor, constant: 12),
            hintView.bottomAnchor.constraint(equalTo: limitView.topAnchor, constant: -12),
            
            arrow.bottomAnchor.constraint(equalTo: hintView.topAnchor, constant: 5),
        ])
        
        arrowLeftPosition = arrow.centerXAnchor.constraint(equalTo: b1.centerXAnchor)
        arrowRightPosition = arrow.centerXAnchor.constraint(equalTo: b2.centerXAnchor)
        
        arrowRightPosition.isActive = true
        
        self.hintView = hintView
        
        b1.onPress = { [weak self] in
            try? self?.viewModel.setMaxRules()
        }
        
        b2.onPress = { [weak self] in
            try? self?.viewModel.setMinRules()
        }
    }
    
}
