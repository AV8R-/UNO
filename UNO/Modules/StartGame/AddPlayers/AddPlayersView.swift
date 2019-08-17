import UIKit
import SnapKit
import ReactiveKit
import Bond

final class AddPlayersView: UIView {
    var viewModel: AddPlayersViewModel
    let disposeBag = DisposeBag()

    private let search = SearchPlayerView()
    private let list = PlayersListView()

    init(viewModel: AddPlayersViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        loadView()
        bindData()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func loadView() {
        backgroundColor = .clear
        let background = UIView().configured(with: Styles.background)
        search.delegate = self

        addSubview(background)
        addSubview(search)
        addSubview(list)

        background.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(Constants.backgroundInsets)
        }

        search.snp.makeConstraints { make in
            make.top.equalTo(background).offset(Constants.searchTopInset)
            make.left.equalTo(background).offset(Constants.searchSideInsets)
            make.right.equalTo(background).offset(-Constants.searchSideInsets)
        }

        list.snp.makeConstraints { make in
            make.top.equalTo(search.snp.bottom).offset(Constants.listInsets.top)
            make.left.equalTo(background).offset(Constants.listInsets.left)
            make.bottom.equalTo(background).offset(-Constants.listInsets.bottom)
            make.right.equalTo(background).offset(-Constants.listInsets.right)
        }
    }
    
    func showError(_ error: Error) {
        print(error)
    }

    func bindData() {
        viewModel.players.bind(to: list, using: .init { (players, indexPath, tableView) -> UITableViewCell in
            let cell: PlayerListCell = tableView.dequeueAndRegisterCell()
            let player = players[indexPath.row]
            cell.textLabel?.text = player.name
            cell.minusButton.reactive.controlEvents(.touchUpInside)
                .observeNext { [unowned self] _ in
                    self.viewModel.removePlayer(player)
                }
                .dispose(in: self.disposeBag)
            return cell
        })

        viewModel.players
            .observeNext { changeset in
                print(changeset.collection)
            }
            .dispose(in: disposeBag)
        
        search.addButton.reactive.tap
            .observeNext { [unowned input = search.inputField, unowned self] _ in
                _ = self.textFieldShouldReturn(input)
            }
            .dispose(in: disposeBag)
        
        search.keyboardToolbar.startGameButton.reactive.tap
            .observeNext { [unowned self] _ in
                self.io.finish()
            }
            .dispose(in: disposeBag)

    }
}

extension AddPlayersView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        try? viewModel.appendPlayer(name: textField.text ?? "")
        textField.text = nil
        return false
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
}

private enum Constants {
    static let backgroundInsets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
    static let cornerRadius: CGFloat = 15

    static let searchTopInset: CGFloat = 30
    static let searchSideInsets: CGFloat = 10
    static let listInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
}
