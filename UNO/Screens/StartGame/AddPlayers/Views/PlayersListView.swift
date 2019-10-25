import UIKit

final class PlayersListView: UITableView {
    init() {
        super.init(frame: .zero, style: .plain)
        loadView()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func loadView() {
        let background = BackgroundView().configured(with: Styles.background)
        backgroundView = background
        tableFooterView = UIView()
        allowsSelection = false
        separatorStyle = .none
    }
}

private enum Styles {
    static func background(_ background: BackgroundView) {
        background.backgroundColor = .lightGreen
        background.shadowColor = .darkGreen
        background.layer.cornerRadius = Constants.cornerRadius
    }
}

private enum Constants {
    static let cornerRadius: CGFloat = 20
}
