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
        case .title1: return 24
        default: return 14
        }
    }
    
    private static func prefferedFontName(forTextStyle: UIFontTextStyle) -> String {
        switch forTextStyle {
        case .headline: return "HelveticaNeue-CondensedBold"
        case .title1: return "HelveticaNeue-CondensedBlack"
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
