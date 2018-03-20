//
//  PageView.swift
//  Core-UI
//
//  Created by Богдан Маншилин on 20/03/2018.
//  Copyright © 2018 BManshilin. All rights reserved.
//

import Foundation

class PageView: UIScrollView {
    weak var pages: UIStackView!
    var lastUnlockedPage = 0
    
    var progressedSteps: [ProgressedStep] {
        return pages.arrangedSubviews.flatMap { $0 as? ProgressedStep }
    }
    
    var didShowPage: ((Int) -> Void)?
    
    var currentPage: Int {
        return Int(contentOffset.x / bounds.width)
    }
    
    override var bounds: CGRect {
        didSet {
            self.blockPages(from: self.lastUnlockedPage+1)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        isPagingEnabled = true
        
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stackView)
        stackView.axis = .horizontal
        stackView.backgroundColor = .cyan
        self.pages = stackView
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.leftAnchor.constraint(equalTo: leftAnchor),
            stackView.rightAnchor.constraint(equalTo: rightAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            ])
        
        delegate = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func append(page: UIView) {
        pages.addArrangedSubview(page)
        NSLayoutConstraint.activate([
            page.heightAnchor.constraint(equalTo: heightAnchor),
            page.widthAnchor.constraint(equalTo: widthAnchor),
            ])
    }
    
    func blockPages(from: Int) {
        guard pages.arrangedSubviews.count > from,
            from > 0 else
        {
            return
        }
        lastUnlockedPage = from - 1
        
        let last = CGFloat(pages.arrangedSubviews.count-from)
        
        contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -bounds.width * last)
    }
    
    func unlockPages(upTo: Int) {
        guard pages.arrangedSubviews.count >= upTo,
            upTo > 0 else
        {
            return
        }
        lastUnlockedPage = upTo - 1
        
        let last = CGFloat(pages.arrangedSubviews.count - upTo)
        
        contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -bounds.width * last)
        
    }
    
    func scrollTo(page: Int) {
        guard pages.arrangedSubviews.count > page else {
            return
        }
        let page = pages.arrangedSubviews[page]
        scrollRectToVisible(page.frame, animated: true)
    }
    
    func scrollBack() {
        guard contentOffset.x > 0 else {
            return
        }
        var origin = contentOffset
        origin.x -= bounds.width
        let rect = CGRect(origin: origin, size: bounds.size)
        scrollRectToVisible(rect, animated: true)
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
        didShowPage?(currentPage)
        progressedSteps[currentPage].didShow()
    }
    
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        didShowPage?(currentPage)
        progressedSteps[currentPage].didShow()
    }
}
