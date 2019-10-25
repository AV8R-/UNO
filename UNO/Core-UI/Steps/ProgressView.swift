import UIKit
import SnapKit

class ProgressView: UIControl {
    
    enum PrimaryAction {
        case back
        case forward
    }
    
    private var controlButtonsView: UIStackView!
    private var numberButtonsView: UIStackView!

    @IBInspectable var numberButtonsCount: Int = 0 {
        didSet {
            setupNumberButtons()
        }
    }
    
    var selectedNumber: Int = 0 {
        didSet {
            guard selectedNumber != oldValue else {
                return
            }
            
            switch selectedNumber {
            case ..<0:
                primaryAction = .back
                sendActions(for: .primaryActionTriggered)
                
            case 0..<numberButtonsCount:
                primaryAction = nil
                sendActions(for: .valueChanged)
                
            case numberButtonsCount...:
                primaryAction = .forward
                sendActions(for: .primaryActionTriggered)
                
            default:
                fatalError()
            }
            
            selectedNumber = (0...numberButtonsCount-1).clamp(selectedNumber)
            updateSelectedButton()
        }
    }
    
    var primaryAction: PrimaryAction?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    // MARK: - Setup
    
    private func setupView() {
        backgroundColor = .clear
        setupLine()
        setupContolButtonsStackView()
        setupNumberButtons()
    }
    
    private func setupLine() {
        let line = UIView()
        line.translatesAutoresizingMaskIntoConstraints = false
        line.backgroundColor = .white
        addSubview(line)
        
        line.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(48)
            make.height.equalTo(10)
            make.centerY.equalToSuperview()
        }
    }
        
    private func setupContolButtonsStackView() {
        controlButtonsView = UIStackView()
        controlButtonsView.spacing = 20
        controlButtonsView.translatesAutoresizingMaskIntoConstraints = false
        controlButtonsView.axis = .horizontal
        
        let backButton = StepProgressButton(kind: .back)
        controlButtonsView.addArrangedSubview(backButton)
        
        let spacing = UIView()
        spacing.translatesAutoresizingMaskIntoConstraints = false
        controlButtonsView.addArrangedSubview(spacing)
        spacing.snp.makeConstraints { $0.height.equalToSuperview() }
        
        let forwardButton = StepProgressButton(kind: .forward(selectedColor: tintColor))
        controlButtonsView.addArrangedSubview(forwardButton)
        
        addSubview(controlButtonsView)

        controlButtonsView.snp.makeConstraints { $0.edges.equalToSuperview() }
        
        backButton.onPress = { [weak self] in
            guard let self = self else {
                return
            }
            
            self.selectedNumber -= 1
        }
        
        forwardButton.onPress = { [weak self] in
            self?.selectedNumber += 1
        }
    }
    
    private func setupNumberButtons() {
        if numberButtonsView == nil {
            numberButtonsView = UIStackView()
            numberButtonsView.spacing = 12
            numberButtonsView.translatesAutoresizingMaskIntoConstraints = false
            numberButtonsView.axis = .horizontal
        }
        
        if numberButtonsView.arrangedSubviews.count > 0 {
            numberButtonsView.arrangedSubviews.forEach {
                numberButtonsView.removeArrangedSubview($0)
                $0.removeFromSuperview()
            }
        }
        
        for page in 0..<numberButtonsCount {
            let numButton = StepProgressButton(kind: .page(num: page+1, color: tintColor, selectedColor: .white))
            numButton.onPress = { [weak self] in
                self?.selectedNumber = page
            }
            numberButtonsView.addArrangedSubview(numButton)
        }
        
        
        addSubview(numberButtonsView)
        
        numberButtonsView.snp.makeConstraints { make in
            make.top.bottom.equalTo(controlButtonsView)
            make.centerX.equalToSuperview()
        }
        
        updateSelectedButton()
    }
    
    // MARK: - Updates
    
    private func updateSelectedButton() {
        numberButtonsView.arrangedSubviews.enumerated().lazy
            .map { (index: $0, button: $1 as! StepProgressButton) }
            .forEach { $0.button.isSelected = $0.index == selectedNumber }
    }
}
