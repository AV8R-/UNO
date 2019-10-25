import UIKit
import SnapKit

class PageView: UIScrollView {
    weak var pages: UIStackView!
    
    var progressedSteps: [ProgressedStep] {
        return pages.arrangedSubviews.compactMap { $0 as? ProgressedStep }
    }
    
    private var didShowPageHandlers: [(Int) -> Void] = []
    
    var currentPage: Int {
        return Int(contentOffset.x / max(bounds.width, 1))
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    private func setup() {
        backgroundColor = .clear
        isPagingEnabled = true
        
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stackView)
        stackView.axis = .horizontal
        stackView.backgroundColor = .cyan
        self.pages = stackView
        
        stackView.snp.makeConstraints { $0.edges.equalToSuperview() }
                
        delegate = self
    }
    
    func append(didSHhowPageHandler handler: @escaping (Int) -> Void) {
        self.didShowPageHandlers.append(handler)
        handler(currentPage)
    }
    
    func append(page: UIView) {
        pages.addArrangedSubview(page)
        NSLayoutConstraint.activate([
            page.heightAnchor.constraint(equalTo: heightAnchor),
            page.widthAnchor.constraint(equalTo: widthAnchor),
            ])
    }
    
    func scrollTo(page: Int) {
        guard pages.arrangedSubviews.count > page else {
            return
        }
        let page = pages.arrangedSubviews[page]
        scrollRectToVisible(page.frame, animated: true)
    }
    
    @discardableResult
    func scrollBack() -> Bool {
        guard contentOffset.x > 0 else {
            return false
        }
        var origin = contentOffset
        origin.x -= bounds.width
        let rect = CGRect(origin: origin, size: bounds.size)
        scrollRectToVisible(rect, animated: true)
        return true
    }
    
    @discardableResult
    func scrollForward() -> Bool {
        guard contentOffset.x < contentSize.width - bounds.width else {
            return false
        }
        var origin = contentOffset
        origin.x += bounds.width
        let rect = CGRect(origin: origin, size: bounds.size)
        scrollRectToVisible(rect, animated: true)
        return true
    }
}

extension PageView: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        didShowPageHandlers.forEach { $0(currentPage) }
        progressedSteps[currentPage].io.didShow()
    }
    
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        didShowPageHandlers.forEach { $0(currentPage) }
        progressedSteps[currentPage].io.didShow()
    }
}
