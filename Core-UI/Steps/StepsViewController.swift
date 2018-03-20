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
    let pages: [UIView & ProgressedStep]
    
    public init(pages: [UIView & ProgressedStep]) {
        self.pages = pages
        super.init(nibName: nil, bundle: nil)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override public func loadView() {
        let view = UIView()
        view.backgroundColor = .black
        
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
        pagedContainer.backgroundColor = .blue
        view.addSubview(pagedContainer)
        NSLayoutConstraint.activate([
            pagedContainer.topAnchor.constraint(equalTo: view.topAnchor, constant: 140),
            pagedContainer.leftAnchor.constraint(equalTo: view.leftAnchor),
            pagedContainer.rightAnchor.constraint(equalTo: view.rightAnchor),
            pagedContainer.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -60),
            ])
        
        for step in pages {
            pagedContainer.append(page: step)
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
