//
//  MainMenuView.swift
//  Views
//
//  Created by Богдан Маншилин on 15/02/2018.
//  Copyright © 2018 BManshilin. All rights reserved.
//

import UIKit

public final class MainMenuView: UIViewController {
    
    enum Constants {
        static let cellReuse = "cell"
        static let cellSize = CGSize(width: 160, height: 232)
    }
    
    public final class MenuCollectionController: UICollectionViewController {
        public override func viewDidLoad() {
            super.viewDidLoad()
            collectionView?.register(UICollectionViewCell.self, forCellWithReuseIdentifier: Constants.cellReuse)
            collectionView?.backgroundColor = .magenta
        }
        public override func numberOfSections(in collectionView: UICollectionView) -> Int {
            return 1
        }
        
        public override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return 4
        }
        
        public override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.cellReuse, for: indexPath)
            cell.contentView.backgroundColor = .black
            return cell
        }
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        let layout = UICollectionViewFlowLayout()
        layout.estimatedItemSize = Constants.cellSize
        layout.itemSize = Constants.cellSize
        
        let menu = MenuCollectionController(collectionViewLayout: layout)
        
        addChildViewController(menu)
        menu.willMove(toParentViewController: self)
        menu.view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(menu.view)
        NSLayoutConstraint.activate([
            menu.view.topAnchor.constraint(equalTo: view.topAnchor, constant: 143),
            menu.view.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -45),
            menu.view.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            menu.view.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
        ])
        menu.didMove(toParentViewController: self)
        
    }
    
}
