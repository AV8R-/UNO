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
        
        pages.forEach { pagedContainer.append(page: $0.view) }
        
        pagedContainer.observeDidShowPageHandler { [weak self] page in
            self?.titleLabel.text = self?.pages[page].io.title
        }
    }
    
    @IBAction func didSelectPage(_ sender: ProgressView) {
        pagedContainer.scrollTo(page: sender.selectedNumber)
    }
    
    @IBAction func didSelectPrimaryAction(_ sender: ProgressView) {
        switch sender.primaryAction {
        case .back:
            performSegue(withIdentifier: Segues.unwind.rawValue, sender: self)
            
        case .forward:
            performSegue(withIdentifier: Segues.game.rawValue, sender: self)
            
        case nil:
            break
        }
    }
}

private enum Segues: String {
    case unwind
    case game
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
