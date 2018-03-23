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
        backgroundColor = .white
        layer.cornerRadius = 15
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
