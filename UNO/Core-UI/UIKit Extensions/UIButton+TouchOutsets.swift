import UIKit

private var pTouchAreaEdgeInsets: UIEdgeInsets = .zero

extension UIButton {
    var touchOutsets: UIEdgeInsets {
        get {
            guard let value = objc_getAssociatedObject(self, &pTouchAreaEdgeInsets) as? NSValue else {
                return .zero
            }

            var edgeInsets: UIEdgeInsets = .zero
            value.getValue(&edgeInsets)
            return edgeInsets
        }

        set(newValue) {
            var newValueCopy = newValue
            let objCType = NSValue(uiEdgeInsets: .zero).objCType
            let value = NSValue(&newValueCopy, withObjCType: objCType)
            objc_setAssociatedObject(self, &pTouchAreaEdgeInsets, value, .OBJC_ASSOCIATION_RETAIN)
        }
    }

    open override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        guard touchOutsets != .zero, isEnabled, isHidden != true else {
            return super.point(inside: point, with: event)
        }

        let hitFrame = UIEdgeInsetsInsetRect(bounds, touchOutsets)
        return hitFrame.contains(point)
    }
}
