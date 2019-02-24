import UIKit

struct Shadow {
    let x: CGFloat
    let y: CGFloat
    let radius: CGFloat
    let color: UIColor
    let opacity: Float

    init(
        x: CGFloat = 0,
        y: CGFloat = 0,
        radius: CGFloat = 0,
        color: UIColor = .black,
        opacity: Float = 1
    ) {
        self.x = x
        self.y = y
        self.radius = radius
        self.color = color
        self.opacity = opacity
    }
}

extension UIView {
    func apply(shadow: Shadow) {
        layer.shadowColor = shadow.color.cgColor
        layer.shadowOffset = CGSize(width: shadow.x, height: shadow.y)
        layer.shadowOpacity = shadow.opacity
        layer.shadowRadius = shadow.radius
    }
}
