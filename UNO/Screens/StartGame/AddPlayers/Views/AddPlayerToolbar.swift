import UIKit

final class AddPlayerToolBar: UIToolbar {
    
    let startGameButton = UIBarButtonItem(
        title: NSLocalizedString("Start", comment: ""),
        style: .done,
        target: nil,
        action: nil
    )
    
    let hideKeyboardButton = UIBarButtonItem(
        title: NSLocalizedString("Hide", comment: ""),
        style: .plain,
        target: nil,
        action: nil
    )
    
    init() {
        super.init(frame: .zero)
        barStyle = UIBarStyle.default
        isTranslucent = true
        sizeToFit()
        isUserInteractionEnabled = true
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        tintColor = .darkGreen
        setItems(
            [
                hideKeyboardButton,
                UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil),
                startGameButton,
            ],
            animated: false
        )
    }
    
    private func startGamePressed(_ sender: Any) {
        
    }
}
