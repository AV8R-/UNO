import UIKit

extension UILabel {
    struct Style {
        let font: UIFont
        let color: UIColor
        let aligment: NSTextAlignment
        let numberOfLines: Int

        init(font: UIFont, color: UIColor, aligment: NSTextAlignment = .left, numberOfLines: Int = 1) {
            self.font = font
            self.color = color
            self.aligment = aligment
            self.numberOfLines = numberOfLines
        }
    }

    convenience init(style: Style) {
        self.init()
        apply(style)
    }

    @discardableResult
    func apply(_ style: Style) -> Self {
        font = style.font
        textColor = style.color
        textAlignment =  style.aligment
        numberOfLines = style.numberOfLines
        return self
    }
}
