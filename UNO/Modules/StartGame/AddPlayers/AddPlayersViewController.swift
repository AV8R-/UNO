//
//  AddPlayersViewController.swift
//  Views
//
//  Created by Богдан Маншилин on 31/03/2018.
//  Copyright © 2018 BManshilin. All rights reserved.
//

import UIKit

public protocol AddPlayersViewControlling: ProgressedStep {}

final class AddPlayersViewController: UIView, AddPlayersViewControlling {
    var viewModel: AddPlayersViewModelling
    var io: ProgressedStepIO
    var view: UIView! {
        return self
    }
    
    init(viewModel: AddPlayersViewModelling, io: ProgressedStepIO) {
        self.viewModel = viewModel
        self.io = io
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        loadView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func loadView() {
        backgroundColor = .clear
        
        let background = UIView()
        background.translatesAutoresizingMaskIntoConstraints = false
        background.backgroundColor = .white
        background.layer.cornerRadius = 15
        
        let searchBackground = BackgroundView(
            color: .lightGreen,
            shadowColor: .darkGreen,
            cornerRadius: 20
        )
        
        let listBackground = BackgroundView(
            color: .lightGreen,
            shadowColor: .darkGreen,
            cornerRadius: 20
        )
        
        addSubview(background)
        addSubview(searchBackground)
        addSubview(listBackground)
        
        NSLayoutConstraint.activate([
            background.topAnchor.constraint(equalTo: topAnchor),
            background.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            background.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            background.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            searchBackground.topAnchor.constraint(equalTo: background.topAnchor, constant: 30),
            searchBackground.leadingAnchor.constraint(equalTo: background.leadingAnchor, constant: 10),
            searchBackground.trailingAnchor.constraint(equalTo: background.trailingAnchor, constant: -10),
            searchBackground.heightAnchor.constraint(equalToConstant: 75),
            
            listBackground.topAnchor.constraint(equalTo: searchBackground.bottomAnchor, constant: 10),
            listBackground.leadingAnchor.constraint(equalTo: background.leadingAnchor, constant: 10),
            listBackground.trailingAnchor.constraint(equalTo: background.trailingAnchor, constant: -10),
            listBackground.bottomAnchor.constraint(equalTo: background.bottomAnchor, constant: -10),
        ])
    }
    
}
