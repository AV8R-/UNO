import Foundation

enum Swizzle {
    static func swizzle(for forClass: AnyClass, original: Selector, swizzled: Selector) {
        let originalMethod = class_getInstanceMethod(forClass, original)!
        let swizzledMethod = class_getInstanceMethod(forClass, swizzled)!
        method_exchangeImplementations(originalMethod, swizzledMethod)
    }
}
