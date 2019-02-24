import UIKit

private extension CGFloat {
    static let minTouchValue: CGFloat = 44
}

private extension UIEdgeInsets {
    func inverted() -> UIEdgeInsets {
        return UIEdgeInsets(top: -top, left: -left, bottom: -bottom, right: -right)
    }
}

extension UIView {
    private struct AssociatedKeys {
        static var touchInsets = "touchInsets"
    }

    enum TouchInsets {
        case none
        case keepMinimum
        case keep(UIEdgeInsets)
    }

    var touchInsets: TouchInsets {
        get {
            return associatedObject(for: &AssociatedKeys.touchInsets) ?? .none
        }
        set {
            setAssociatedObject(newValue, for: &AssociatedKeys.touchInsets)
        }
    }

    static func insetsInit() {
        Swizzle.swizzle(for: self,
                        original: #selector(point(inside:with:)),
                        swizzled: #selector(_point(inside:with:))
        )
    }

    @objc func _point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        let result: Bool

        switch touchInsets {

        case .none:
            result = _point(inside: point, with: event)

        case .keepMinimum:
            var minInsets = UIEdgeInsets.zero
            if frame.size.width < .minTouchValue {
                minInsets.right = (.minTouchValue - frame.size.width) / 2
                minInsets.left = (.minTouchValue - frame.size.width) / 2
            }
            if frame.size.height < .minTouchValue {
                minInsets.bottom = (.minTouchValue - frame.size.height) / 2
                minInsets.top = (.minTouchValue - frame.size.height) / 2
            }

            result = contains(point, with: minInsets) ? true : _point(inside: point, with: event)

        case .keep(let insets):
            result = contains(point, with: insets) ? true : _point(inside: point, with: event)
        }

        return result
    }

    private func contains(_ point: CGPoint, with insets: UIEdgeInsets) -> Bool {
        return bounds.inset(by: insets.inverted()).contains(point)
    }
}

