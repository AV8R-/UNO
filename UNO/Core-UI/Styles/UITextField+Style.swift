import UIKit

extension UITextField {
    struct Style {
        let font: UIFont
        let textColor: UIColor
        let placeholder: String?
        let tintColor: UIColor?
        let keyboardType: UIKeyboardType?
        let returnKeyType: UIReturnKeyType?
        let autocorrection: UITextAutocorrectionType

        init(
            font: UIFont,
            textColor: UIColor,
            placeholder: String? = nil,
            tintColor: UIColor? = nil,
            keyboardType: UIKeyboardType? = nil,
            returnKeyType: UIReturnKeyType? = nil,
            autocorrection: UITextAutocorrectionType = .default
        ) {
            self.font = font
            self.textColor = textColor
            self.placeholder = placeholder
            self.tintColor = tintColor
            self.keyboardType = keyboardType
            self.returnKeyType = returnKeyType
            self.autocorrection = autocorrection
        }
    }

    convenience init(style: Style) {
        self.init(frame: .zero)
        apply(style)
    }

    func apply(_ style: Style) {
        font = style.font
        textColor = style.textColor
        placeholder = style.placeholder
        autocorrectionType = style.autocorrection

        if let returnKeyType = style.returnKeyType {
            self.returnKeyType = returnKeyType
        }

        if let keyboardType = style.keyboardType {
            self.keyboardType = keyboardType
        }

        if let tintColor = style.tintColor {
            self.tintColor = tintColor
        }
    }
}
