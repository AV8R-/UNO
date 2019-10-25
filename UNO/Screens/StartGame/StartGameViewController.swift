import UIKit

final class StartGameViewController: UIViewController, Resolving {
    
    @IBOutlet weak var pagedContainer: PageView!
    @IBOutlet weak var titleLabel: UILabel! {
        didSet {
            Style.setupTitleLabel(titleLabel)
        }
    }
    
    private lazy var pages: [ProgressedStep] = [
        ChooseRulesView(viewModel: ChooseRulesViewModel(picker: try! self.resolve())),
        AddPlayersView(viewModel: AddPlayersViewModel(playersService: try! self.resolve())),
    ]
    
    override var title: String? {
        didSet {
            titleLabel.text = title
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        for step in pages {
            pagedContainer.append(page: step.view)
        }
        
        pagedContainer.append { [weak self] page in
            self?.titleLabel.text = self?.pages[page].io.title
        }

    }
}

private enum Style {
    static func setupTitleLabel(_ titleLabel: UILabel) {
        titleLabel.textColor = .white
        titleLabel.font = .unoFont(forTextStyle: .title2)
        titleLabel.layer.shadowColor = UIColor.black.cgColor
        titleLabel.layer.shadowOffset = CGSize(width: 0, height: 4)
        titleLabel.layer.shadowRadius = 4
        titleLabel.layer.shadowOpacity = 0.25
    }
}
