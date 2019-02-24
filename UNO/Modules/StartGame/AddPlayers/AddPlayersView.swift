import UIKit
import SnapKit

final class AddPlayersView: UIView, ProgressedStep {
    var viewModel: AddPlayersViewModel
    var io: ProgressedStepIO {
        return viewModel
    }
    var view: UIView! {
        return self
    }
    
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
        
        let background = UIView()
        background.translatesAutoresizingMaskIntoConstraints = false
        background.backgroundColor = .white
        background.layer.cornerRadius = 15
        
        let searchBackground = BackgroundView(
            color: .lightGreen,
            shadowColor: .darkGreen,
            cornerRadius: 20
        )
        
        let listBackground = BackgroundView(
            color: .lightGreen,
            shadowColor: .darkGreen,
            cornerRadius: 20
        )
        
        addSubview(background)
        addSubview(searchBackground)
        addSubview(listBackground)

        background.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(Constants.backgroundInsets)
        }

        searchBackground.snp.makeConstraints { make in
            make.top.equalTo(background).offset(Constants.searchTopInset)
            make.left.equalTo(background).offset(Constants.searchSideInsets)
            make.right.equalTo(background).offset(-Constants.searchSideInsets)
            make.height.equalTo(Constants.searchHeight)
        }

        listBackground.snp.makeConstraints { make in
            make.top.equalTo(searchBackground.snp.bottom).offset(Constants.listInsets.top)
            make.left.equalTo(background).offset(Constants.listInsets.left)
            make.bottom.equalTo(background).offset(-Constants.listInsets.bottom)
            make.right.equalTo(background).offset(-Constants.listInsets.right)
        }
    }
}

private enum Constants {
    static let backgroundInsets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)

    static let searchTopInset: CGFloat = 30
    static let searchSideInsets: CGFloat = 10
    static let searchHeight: CGFloat = 75

    static let listInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
}
