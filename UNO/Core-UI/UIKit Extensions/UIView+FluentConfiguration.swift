import UIKit

protocol FluentConfiguring {}
extension FluentConfiguring {
    func configured(with configure: (Self) -> Void) -> Self {
        configure(self)
        return self
    }
}

extension UIView: FluentConfiguring {}
