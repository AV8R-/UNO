//
//  CardButton.swift
//  Core-UI
//
//  Created by Богдан Маншилин on 10/03/2018.
//  Copyright © 2018 BManshilin. All rights reserved.
//

import UIKit
import AttributedTextView

public final class CardButton: UNOButton {
    
    @IBOutlet var backgroundImage: UIImageView!
    @IBOutlet var titleLabel: UILabel! {
        didSet {
            if let text = titleLabel.text {
                title = text
            }
        }
    }
        
    @IBInspectable var title: String = "" {
        didSet {
            titleLabel.attributedText = title
                .white
                .strokeWidth(-1)
                .strokeColor(.black)
                .font(.unoFont(forTextStyle: .title1))
                .attributedText
        }
    }
}
