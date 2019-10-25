import UIKit
import AttributedTextView

public final class MainMenuViewController: UIViewController {
    
    @IBOutlet var titleLabel: UILabel! {
        didSet {
            _ = titleLabel.configured(with: Styles.titleLabel)
        }
    }
        
    @IBAction func didPressStartGameButton(_ sender: UIButton) {
        performSegue(withIdentifier: Segue.startGame, sender: sender)
    }
    
    @IBAction func didPressContinueGameButton(_ sender: UIButton) {
        performSegue(withIdentifier: Segue.continueGame, sender: sender)
    }
    
    @IBAction func didPressHistoryButton(_ sender: UIButton) {
        performSegue(withIdentifier: Segue.history, sender: sender)
    }
    
    @IBAction func didPressRulesButton(_ sender: UIButton) {
        performSegue(withIdentifier: Segue.rules, sender: sender)
    }
}

private enum Segue {
    static let startGame = "start"
    static let continueGame = "start"
    static let history = "start"
    static let rules = "start"
}

private enum Styles {
    static func titleLabel(_ titleLabel: UILabel) {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.adjustsFontForContentSizeCategory = true
        titleLabel.attributedText = "UNO"
            .color(UIColor.materialYellow)
            .font(UIFont.unoFont(forTextStyle: .headline))
            .strokeColor(.white)
            .strokeWidth(-1)
            .attributedText
        titleLabel.layer.shadowOpacity = 1
        titleLabel.layer.shadowRadius = 4
        titleLabel.layer.shadowColor = UIColor.black.withAlphaComponent(0.5).cgColor
        titleLabel.layer.shadowOffset = CGSize(width: 0, height: 4)
    }
}
