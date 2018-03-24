//
//  Styleguide.swift
//  Views
//
//  Created by Богдан Маншилин on 10/03/2018.
//  Copyright © 2018 BManshilin. All rights reserved.
//

import Foundation

public extension UIFont {
    public static func prefferedFontSize(forTextStyle: UIFontTextStyle) -> CGFloat {
        switch forTextStyle {
        case .headline: return 72
        case .largeTitle: return 64
        case .title1: return 24
        case .body: return 18
        default: return 14
        }
    }
    
    private static func prefferedFontName(forTextStyle: UIFontTextStyle) -> String {
        switch forTextStyle {
        case .headline: return "HelveticaNeue-CondensedBold"
        case .title1, .largeTitle, .body: return "HelveticaNeue-CondensedBlack"
        default: return "HelveticaNeue"
        }
    }
    
    public class func unoFont(forTextStyle: UIFontTextStyle) -> UIFont {
        return UIFontMetrics(forTextStyle: forTextStyle)
            .scaledFont(for: UIFont(
                name: prefferedFontName(forTextStyle: forTextStyle),
                size: prefferedFontSize(forTextStyle: forTextStyle)
                )!
        )
    }
}

public extension UIColor {
    static let materialYellow = UIColor(red: 248/255.0, green: 201/255.0, blue: 33/255.0, alpha: 1)
    static let lightRed = UIColor(red: 255/255.0, green: 182/255.0, blue: 0, alpha: 1)
    static let darkRed = UIColor(red: 236/255.0, green: 27/255.0, blue: 35/255.0, alpha: 1)
    static let lightBlue = UIColor(red: 0/255.0, green: 114/255.0, blue: 187/255.0, alpha: 1)
    static let darkBlue = UIColor(red: 42/255.0, green: 72/255.0, blue: 98/255.0, alpha: 1)
    static let lightGreen = UIColor(red: 78/255.0, green: 171/255.0, blue: 66/255.0, alpha: 1)
    static let darkGreen = UIColor(red: 66/255.0, green: 144/255.0, blue: 57/255.0, alpha: 1)
}
