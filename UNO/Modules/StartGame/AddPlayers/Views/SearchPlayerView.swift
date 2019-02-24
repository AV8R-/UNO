import UIKit

final class SearchPlayerView: UIView {
    let addButton = UIButton(normalStyle: .add).configured(with: Styles.plus)
    let inputField = UITextField(style: .input)

    var delegate: UITextFieldDelegate? {
        set {
            inputField.delegate = newValue
        }
        get {
            return inputField.delegate
        }
    }

    init() {
        super.init(frame: .zero)
        load()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func load() {
        backgroundColor = .clear
        snp.makeConstraints { make in
            make.height.equalTo(Constants.height)
        }

        let background = BackgroundView().configured(with: Styles.background)
        addSubview(background)
        background.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        addSubview(inputField)
        inputField.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(Constants.leftInset)
            make.top.bottom.equalToSuperview()
        }

        inputField.rightView = addButton
        inputField.rightViewMode = .always
    }
}

private enum Styles {
    static func background(_ background: BackgroundView) {
        background.backgroundColor = .lightGreen
        background.shadowColor = .darkGreen
        background.layer.cornerRadius = Constants.cornerRadius
    }

    static func plus(_ button: UIButton) {
        button.snp.makeConstraints { make in
            make.size.equalTo(Constants.addButton.diameter)
        }
        button.setTitle("+", for: .normal)
    }
}

private extension UIButton.Style {
    static let add = UIButton.Style(
        font: .unoFont(forTextStyle: .signBig),
        titleColor: .lightGreen,
        backgroundColor: .white,
        aligment: .center,
        cornerRadius: Constants.addButton.diameter / 2,
        shadow: Shadow(x: 0, y: 0, radius: 10, color: .black, opacity: 0.5),
        insets: UIEdgeInsets(top: -8, left: 0, bottom: 0, right: 0)
    )
}

private extension UITextField.Style {
    static let input = UITextField.Style(
        font: UIFont.unoFont(forTextStyle: .title1),
        textColor: .white,
        placeholder: NSLocalizedString("Enter player name", comment: ""),
        tintColor: .white,
        keyboardType: .namePhonePad,
        returnKeyType: .default,
        autocorrection: .no
    )
}

private enum Constants {
    enum addButton {
        static let diameter: CGFloat = 26
        static let rightInset: CGFloat = 20
    }

    static let leftInset: CGFloat = 20

    static let cornerRadius: CGFloat = 20
    static let height: CGFloat = 75
}
