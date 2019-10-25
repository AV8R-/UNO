import UIKit
import SnapKit

class ProgressView: UIControl {
    
    private var controlButtonsView: UIStackView!
    private var numberButtonsView: UIStackView!

    @IBInspectable var numberButtonsCount: Int = 0 {
        didSet {
            setupNumberButtons()
        }
    }
    
    var selectedNumer: Int = 0 {
        didSet {
            selectedNumer = (0...numberButtonsCount-1).clamp(selectedNumer)
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
            self?.selectedNumer -= 1
            self?.sendActions(for: .valueChanged)
        }
        
        forwardButton.onPress = { [weak self] in
            self?.selectedNumer += 1
            self?.sendActions(for: .valueChanged)
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
                self?.selectedNumer = page
                self?.sendActions(for: .valueChanged)
            }
            numberButtonsView.addArrangedSubview(numButton)
        }
        
        
        addSubview(numberButtonsView)
        
        numberButtonsView.snp.makeConstraints { make in
            make.top.bottom.equalTo(controlButtonsView)
            make.centerX.equalToSuperview()
        }
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
    
    private func setupView() {
        backgroundColor = .clear
        setupLine()
        setupContolButtonsStackView()
        setupNumberButtons()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
}
