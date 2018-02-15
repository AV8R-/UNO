//
//  ViewController.swift
//  UNO
//
//  Created by Богдан Маншилин on 09/02/2018.
//  Copyright © 2018 BManshilin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("hi", for: .normal)
        button.addTarget(self, action: #selector(configure(_:)), for: .touchUpInside)
        view.addSubview(button)
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }
    
    @objc func configure(_ sender: Any) {
        print("press")
        let button = (sender as! UIButton)
        button.setTitle("\(arc4random_uniform(10))", for: .normal)
        let colors = [UIColor.magenta, .brown, .gray, .blue]
        button.tintColor = colors[Int(arc4random_uniform(3))]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

