import UIKit
import SnapKit

final class PlayerListCell: UITableViewCell, Reusable {
    let button = UNOButton(touchDirection: .diminish).configured(with: Styles.minus)

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        loadView()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func loadView() {
        backgroundColor = .clear

        contentView.addSubview(button)
        button.snp.makeConstraints { make in
            make.right.equalToSuperview().inset(Constants.button.rightInset)
            make.centerY.equalToSuperview()
        }

        textLabel?.apply(.title)
    }
}

private enum Styles {
    static func minus(_ button: UNOButton) {
        button.backgroundColor = .white
        button.layer.cornerRadius = Constants.button.diameter / 2
        button.snp.makeConstraints { make in
            make.size.equalTo(Constants.button.diameter)
        }

        let minusSign = UILabel(style: .init(font: .unoFont(forTextStyle: .signSmall), color: .darkRed))
        minusSign.text = "-"
        button.addSubview(minusSign)
        minusSign.snp.makeConstraints { make in
            make.centerY.equalToSuperview().offset(-3)
            make.centerX.equalToSuperview()
        }

        button.apply(shadow: Shadow(x: 0, y: 0, radius: 10, color: .black, opacity: 0.5))
        button.touchInsets = .keep(UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12))
    }
}

private extension UILabel.Style {
    static let title = UILabel.Style(
        font: .unoFont(forTextStyle: .title1),
        color: .white
    )
}

private enum Constants {
    enum button {
        static let diameter: CGFloat = 22
        static let rightInset: CGFloat = 12
    }
}
