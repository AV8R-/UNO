import UIKit
import SnapKit

final class AddPlayersView: UIView {
    var viewModel: AddPlayersViewModel

    init(viewModel: AddPlayersViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        loadView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func loadView() {
        backgroundColor = .clear
        
        let background = UIView().configured(with: Styles.background)
        let search = SearchPlayerView()
        let listBackground = BackgroundView().configured(with: Styles.itemBackground)
        
        addSubview(background)
        addSubview(search)
        addSubview(listBackground)

        background.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(Constants.backgroundInsets)
        }

        search.snp.makeConstraints { make in
            make.top.equalTo(background).offset(Constants.searchTopInset)
            make.left.equalTo(background).offset(Constants.searchSideInsets)
            make.right.equalTo(background).offset(-Constants.searchSideInsets)
        }

        listBackground.snp.makeConstraints { make in
            make.top.equalTo(search.snp.bottom).offset(Constants.listInsets.top)
            make.left.equalTo(background).offset(Constants.listInsets.left)
            make.bottom.equalTo(background).offset(-Constants.listInsets.bottom)
            make.right.equalTo(background).offset(-Constants.listInsets.right)
        }
    }

    func showError(_ error: Error) {
        print(error)
    }
}

extension AddPlayersView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.text = nil
        viewModel.didEnter(text: textField.text ?? "")
        return true
    }
}

extension AddPlayersView: ProgressedStep {
    var io: ProgressedStepIO {
        return viewModel
    }
    var view: UIView! {
        return self
    }
}

private enum Styles {
    static func background(_ background: UIView) -> Void {
        background.translatesAutoresizingMaskIntoConstraints = false
        background.backgroundColor = .white
        background.layer.cornerRadius = Constants.cornerRadius
    }

    static func itemBackground(_ background: BackgroundView) {
        background.backgroundColor = .lightGreen
        background.shadowColor = .darkGreen
        background.layer.cornerRadius = Constants.itemsCornerRadius
    }
}

private enum Constants {
    static let backgroundInsets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)

    static let cornerRadius: CGFloat = 15
    static let itemsCornerRadius: CGFloat = 20

    static let searchTopInset: CGFloat = 30
    static let searchSideInsets: CGFloat = 10

    static let listInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
}
