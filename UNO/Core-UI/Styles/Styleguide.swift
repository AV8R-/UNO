//
//  Styleguide.swift
//  Views
//
//  Created by Богдан Маншилин on 10/03/2018.
//  Copyright © 2018 BManshilin. All rights reserved.
//

import UIKit

extension UIFont {
    public static func prefferedFontSize(forTextStyle: UIFont.TextStyle) -> CGFloat {
        switch forTextStyle {
        case .signBig: return 36
        case .signSmall: return 30
        case .headline: return 72
        case .largeTitle: return 64
        case .title1: return 24
        case .title2: return 36
        case .body: return 18
        default: return 14
        }
    }
    
    private static func prefferedFontName(forTextStyle: UIFont.TextStyle) -> String {
        switch forTextStyle {
        case .headline: return "HelveticaNeue-CondensedBold"
        case .signBig, .signSmall, .title1, .title2, .largeTitle, .body: return "HelveticaNeue-CondensedBlack"
        default: return "HelveticaNeue"
        }
    }
    
    public class func unoFont(forTextStyle: UIFont.TextStyle) -> UIFont {
        return UIFontMetrics(forTextStyle: forTextStyle)
            .scaledFont(
                for: UIFont(
                    name: prefferedFontName(forTextStyle: forTextStyle),
                    size: prefferedFontSize(forTextStyle: forTextStyle)
                )!
            )
    }
}

extension UIFont.TextStyle {
    static let signBig = UIFont.TextStyle(rawValue: "uno_sign")
    static let signSmall = UIFont.TextStyle(rawValue: "uno_sign")
}

extension UIColor {
    static let materialYellow =  UIColor(named: "materialYellow")!
    static let lightRed = UIColor(named: "lightRed")!
    static let darkRed = UIColor(named: "darkRed")!
    static let lightBlue = UIColor(named: "lightBlue")!
    static let darkBlue = UIColor(named: "darkBlue")!
    static let lightGreen = UIColor(named: "lightGreen")!
    static let darkGreen = UIColor(named: "darkGreen")!
}
