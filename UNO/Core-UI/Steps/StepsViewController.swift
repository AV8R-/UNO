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
    public var onClose: (() -> Void)?
    var tintColor: UIColor
    
    public init(pages: [ProgressedStep], tintColor: UIColor) {
        self.pages = pages
        self.tintColor = tintColor
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
            UIColor.lightBlue,
            UIColor.darkBlue,
        ]
        
        view.addSubview(background)
        
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        title.textColor = .white
        view.addSubview(title)
        title.text = self.title
        title.font = .unoFont(forTextStyle: .title2)
        title.layer.shadowColor = UIColor.black.cgColor
        title.layer.shadowOffset = CGSize(width: 0, height: 4)
        title.layer.shadowRadius = 4
        title.layer.shadowOpacity = 0.25
        
        NSLayoutConstraint.activate([
            title.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
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
            pagedContainer.topAnchor.constraint(equalTo: view.topAnchor, constant: 124),
            pagedContainer.leftAnchor.constraint(equalTo: view.leftAnchor),
            pagedContainer.rightAnchor.constraint(equalTo: view.rightAnchor),
            pagedContainer.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -109),
            ])
        
        for step in pages {
            pagedContainer.append(page: step.view)
        }
        
        let progress = ProgressView(pageView: pagedContainer, tintColor: tintColor)
        progress.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(progress)
        
        progress.onClose = { [weak self] in
            self?.onClose?()
        }
        
        NSLayoutConstraint.activate([
            progress.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            progress.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            progress.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -30),
        ])
        
        self.view = view
        
        pagedContainer.append { [weak title, weak self] page in
            title?.text = self?.pages[page].io.title
        }
    }
}
