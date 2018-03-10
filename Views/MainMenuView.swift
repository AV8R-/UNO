//
//  MainMenuView.swift
//  Views
//
//  Created by Богдан Маншилин on 15/02/2018.
//  Copyright © 2018 BManshilin. All rights reserved.
//

import UIKit
import Core_UI
import AttributedTextView

public final class MainMenuView: UIViewController {
    
    enum Constants {
        static let cellReuse = "cell"
        static let cellSize = CGSize(width: 160, height: 232)
        static let bundle = Bundle(for: MainMenuView.self)
        static let backgrounds: [UIImage] = [
            UIImage(named: "card_green", in: bundle, compatibleWith: nil)!,
            UIImage(named: "card_yellow", in: bundle, compatibleWith: nil)!,
            UIImage(named: "card_blue", in: bundle, compatibleWith: nil)!,
            UIImage(named: "card_red", in: bundle, compatibleWith: nil)!,
            ]
    }
    
    public final class MenuCollectionController: UICollectionViewController {
        public override func viewDidLoad() {
            super.viewDidLoad()
            collectionView?.backgroundColor = .clear
            collectionView?.register(UICollectionViewCell.self, forCellWithReuseIdentifier: Constants.cellReuse)
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
            let bg = UIImageView(image: Constants.backgrounds[indexPath.item])
            cell.contentView.addSubview(bg)
            cell.contentView.backgroundColor = .clear
            bg.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                bg.topAnchor.constraint(equalTo: cell.contentView.topAnchor),
                bg.bottomAnchor.constraint(equalTo: cell.contentView.bottomAnchor),
                bg.leftAnchor.constraint(equalTo: cell.contentView.leftAnchor),
                bg.rightAnchor.constraint(equalTo: cell.contentView.rightAnchor),
            ])
            return cell
        }
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        // Background
        let bg = UNOBackground()
        bg.backgroundColor = .clear
        bg.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(bg)
        
        // Buttons
        
        let layout = UICollectionViewFlowLayout()
        let width = (view.bounds.width - 60)/2
        let height = width * 232/160
        
        layout.itemSize = CGSize(width: width, height: height)
        let buttons = MenuCollectionController(collectionViewLayout: layout)
        buttons.view.translatesAutoresizingMaskIntoConstraints = false
        buttons.willMove(toParentViewController: self)
        addChildViewController(buttons)
        view.addSubview(buttons.view)

        // Title
        let titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.adjustsFontForContentSizeCategory = true
        titleLabel.attributedText = "UNO"
            .color(UIColor(red: 242/255.0, green: 201/255.0, blue: 76/255.0, alpha: 1))
            .font(UIFont.unoFont(forTextStyle: .headline))
            .strokeColor(.white)
            .strokeWidth(-1)
            .attributedText
        titleLabel.layer.shadowOpacity = 1
        titleLabel.layer.shadowRadius = 4
        titleLabel.layer.shadowColor = UIColor.black.withAlphaComponent(0.5).cgColor
        titleLabel.layer.shadowOffset = CGSize(width: 0, height: 4)

        view.addSubview(titleLabel)
        
        // Constraints
        
        NSLayoutConstraint.activate([
            bg.topAnchor.constraint(equalTo: view.topAnchor),
            bg.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            bg.leftAnchor.constraint(equalTo: view.leftAnchor),
            bg.rightAnchor.constraint(equalTo: view.rightAnchor),
            
            buttons.view.topAnchor.constraint(equalTo: view.topAnchor, constant: 145),
            buttons.view.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -45),
            buttons.view.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            buttons.view.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 32),
        ])
        
    }
    
}
