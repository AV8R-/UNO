//
//  Styleguide.swift
//  Views
//
//  Created by Богдан Маншилин on 10/03/2018.
//  Copyright © 2018 BManshilin. All rights reserved.
//

import Foundation

extension UIFont {
    class func prefferedFontSize(forTextStyle: UIFontTextStyle) -> CGFloat {
        switch forTextStyle {
        case .headline: return 72
        default: return 14
        }
    }
    
    class func prefferedFontName(forTextStyle: UIFontTextStyle) -> String {
        switch forTextStyle {
        case .headline: return "HelveticaNeue-CondensedBold"
        default: return "HelveticaNeue"
        }
    }
    
    class func unoFont(forTextStyle: UIFontTextStyle) -> UIFont {
        return UIFontMetrics(forTextStyle: forTextStyle)
            .scaledFont(for: UIFont(
                name: prefferedFontName(forTextStyle: forTextStyle),
                size: prefferedFontSize(forTextStyle: forTextStyle)
                )!
        )
    }
}
