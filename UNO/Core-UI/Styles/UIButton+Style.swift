import UIKit

extension UIButton {
    struct Style {
        let font: UIFont?
        let titleColor: UIColor
        let backgroundColor: UIColor
        let imageColor: UIColor?
        let aligment: NSTextAlignment
        let cornerRadius: CGFloat
        let shadow: Shadow?
        let insets: UIEdgeInsets

        init(
            font: UIFont? = nil,
            titleColor: UIColor,
            imageColor: UIColor? = nil,
            backgroundColor: UIColor = .clear,
            aligment: NSTextAlignment = .left,
            cornerRadius: CGFloat = 0,
            shadow: Shadow? = nil,
            insets: UIEdgeInsets = .zero
        ) {
            self.font = font
            self.titleColor = titleColor
            self.backgroundColor = backgroundColor
            self.imageColor = imageColor
            self.aligment = aligment
            self.cornerRadius = cornerRadius
            self.shadow = shadow
            self.insets = insets
        }
    }

    convenience init(styles: [UIControl.State: Style]) {
        self.init(type: .system)
        apply(styles)
    }

    convenience init(normalStyle: Style) {
        self.init(type: .system)
        apply([.normal: normalStyle])
    }

    @discardableResult
    func apply(_ style: Style, for controlState: UIControl.State) -> Self {
        if let font = style.font {
            titleLabel?.font = font
        }
        if let shadow = style.shadow {
            apply(shadow: shadow)
        }
        if let imageColor = style.imageColor {
            tintColor = imageColor
        }

        backgroundColor = style.backgroundColor
        setTitleColor(style.titleColor, for: controlState)
        titleLabel?.textAlignment = style.aligment
        layer.cornerRadius = style.cornerRadius
        contentEdgeInsets = style.insets
        return self
    }

    @discardableResult
    func apply(_ styles: [UIControl.State: Style]) -> Self {
        styles.forEach { arg in
            let (state, style) = arg
            self.apply(style, for: state)
        }
        return self
    }
}

extension UIControl.State: Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(rawValue)
    }
}
