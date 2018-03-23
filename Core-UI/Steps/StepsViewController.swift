//
//  StepsViewController.swift
//  Core-UI
//
//  Created by Богдан Маншилин on 20/03/2018.
//  Copyright © 2018 BManshilin. All rights reserved.
//

import UIKit

public class StepsViewController: UIViewController {
    let pagedContainer: PageView = .init()
    let pages: [ProgressedStep]
    
    public init(pages: [ProgressedStep]) {
        self.pages = pages
        super.init(nibName: nil, bundle: nil)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override public func loadView() {
        let view = UIView()
        view.backgroundColor = .white
        
        let background = UNOBackground()
        background.translatesAutoresizingMaskIntoConstraints = false
        background.colors = [
            UIColor(red: 0/255.0, green: 114/255.0, blue: 187/255.0, alpha: 1),
            UIColor(red: 42/255.0, green: 72/255.0, blue: 98/255.0, alpha: 1),
        ]
        
        view.addSubview(background)
        
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        title.textColor = .white
        view.addSubview(title)
        title.text = self.title
        
        NSLayoutConstraint.activate([
            title.topAnchor.constraint(equalTo: view.topAnchor, constant: 47),
            title.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
        
        pagedContainer.translatesAutoresizingMaskIntoConstraints = false
        pagedContainer.backgroundColor = .clear
        view.addSubview(pagedContainer)
        NSLayoutConstraint.activate([
            background.topAnchor.constraint(equalTo: view.topAnchor),
            background.leftAnchor.constraint(equalTo: view.leftAnchor),
            background.rightAnchor.constraint(equalTo: view.rightAnchor),
            background.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            pagedContainer.topAnchor.constraint(equalTo: view.topAnchor, constant: 140),
            pagedContainer.leftAnchor.constraint(equalTo: view.leftAnchor),
            pagedContainer.rightAnchor.constraint(equalTo: view.rightAnchor),
            pagedContainer.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -60),
            ])
        
        for step in pages {
            pagedContainer.append(page: step.view)
        }
        
        let progress = ProgressView(pageView: pagedContainer)
        progress.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(progress)
        
        NSLayoutConstraint.activate([
            progress.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            progress.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            progress.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -5),
            ])
        
        self.view = view
    }
}
