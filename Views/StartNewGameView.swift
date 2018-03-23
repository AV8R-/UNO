//
//  ChooseRules.swift
//  Views
//
//  Created by Богдан Маншилин on 11/03/2018.
//  Copyright © 2018 BManshilin. All rights reserved.
//

import UIKit
import Core_UI

public protocol StartnewgameViewControlling {}

final class StartNewGameView: UIViewController, StartnewgameViewControlling {
    public override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        let bg = UNOBackground()
        bg.colors = [
            UIColor(red:0, green: 114/255.0, blue: 187/255.0, alpha: 1),
            UIColor(red: 0, green: 30/255.0, blue: 61/255.0, alpha: 0.8),
        ]
        bg.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(bg)
        try! bg.constrainSuperview()
    }
    
}
