//
//  MainMenuView.swift
//  Views
//
//  Created by Богдан Маншилин on 15/02/2018.
//  Copyright © 2018 BManshilin. All rights reserved.
//

import UIKit
import AttributedTextView

public protocol MainMenuDelegate: class {
    func didSelect(menuItem: MainMenuView.MenuItem)
}

public protocol MainMenuViewControlling {}

public final class MainMenuView: UIViewController, MainMenuViewControlling {
    
    public enum MenuItem {
        case start, `continue`, history, rules
        
        fileprivate var title: String {
            let title: String
            switch self {
            case .start: title = "START NEW"
            case .continue: title = "CONTINUE"
            case .history: title = "HISTORY"
            case .rules: title = "RULES"
            }
            return NSLocalizedString(title, comment: "")
        }
        
        fileprivate var background: UIImage {
            let bundle = Constants.bundle
            let title: String
            switch self {
            case .start: title = "card_green"
            case .continue: title = "card_yellow"
            case .history: title = "card_blue"
            case .rules: title = "card_red"
            }
            return UIImage(named: title, in: bundle, compatibleWith: nil)!
        }
            
    }
    
    enum Constants {
        static let cellReuse = "cell"
        static let bundle = Bundle(for: MainMenuView.self)
    }
    
    enum DataSource {
        static let items: [MenuItem] = [.start, .continue, .history, .rules]
    }
    
    public weak var delegate: MainMenuDelegate?
    
    internal final class MenuCollectionController: UICollectionViewController {
        weak var delegate: MainMenuDelegate?

        public override func viewDidLoad() {
            super.viewDidLoad()
            collectionView?.backgroundColor = .clear
            collectionView?.register(UICollectionViewCell.self, forCellWithReuseIdentifier: Constants.cellReuse)
            collectionView?.clipsToBounds = false
        }
        public override func numberOfSections(in collectionView: UICollectionView) -> Int {
            return 1
        }
        
        public override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return 4
        }
        
        public override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: Constants.cellReuse,
                for: indexPath
            )
            let card = CardButton(
                background: DataSource.items[indexPath.item].background,
                title: DataSource.items[indexPath.item].title
            )
            card.onPress = { [weak self] in
                self?.delegate?
                    .didSelect(menuItem: DataSource.items[indexPath.item])
            }
            cell.contentView.addSubview(card)
            try! card.constrainSuperview()
            
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
        buttons.didMove(toParentViewController: self)
        buttons.delegate = self

        // Title
        let titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.adjustsFontForContentSizeCategory = true
        titleLabel.attributedText = "UNO"
            .color(UIColor.materialYellow)
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

extension MainMenuView: MainMenuDelegate {
    public func didSelect(menuItem: MainMenuView.MenuItem) {
        delegate?.didSelect(menuItem: menuItem)
    }
}
