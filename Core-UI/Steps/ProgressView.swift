//
//  ProgressView.swift
//  Core-UI
//
//  Created by Богдан Маншилин on 20/03/2018.
//  Copyright © 2018 BManshilin. All rights reserved.
//

import Foundation

class ProgressView: UIView {
    private weak var pageView: PageView!
    private var steps: [ProgressedStep] = []
    private var allButtons: UIStackView
    private var pages: UIStackView
    
    init(pageView: PageView) {
        allButtons = UIStackView()
        allButtons.spacing = 20
        allButtons.translatesAutoresizingMaskIntoConstraints = false
        allButtons.axis = .horizontal
        
        let backButton = StepProgressButton(kind: .back)
        allButtons.addArrangedSubview(backButton)
        
        backButton.onPress = { [weak pageView] in
            pageView?.scrollBack()
        }
        
        let spacing = UIView()
        spacing.translatesAutoresizingMaskIntoConstraints = false
        allButtons.addArrangedSubview(spacing)
        NSLayoutConstraint.activate([
            spacing.heightAnchor.constraint(equalTo: allButtons.heightAnchor),
            ])
        
        pages =  UIStackView()
        pages.spacing = 12
        pages.translatesAutoresizingMaskIntoConstraints = false
        pages.axis = .horizontal
        
        pageView.didShowPage = { [weak allButtons, weak pages, weak pageView] page in
            (allButtons?.arrangedSubviews.first as? UIControl)?.isSelected = page == 0
            (allButtons?.arrangedSubviews.last as? UIControl)?.isSelected = page == (pages?.arrangedSubviews.count ?? 0) - 1
            let buttons = pages?.arrangedSubviews
                .flatMap { $0 as? UIControl }
            buttons?.forEach { $0.isSelected = false }
            buttons?[page].isSelected = true
            
            if page > 0 {
                pageView?.progressedSteps[page-1].io.finish()
            }
        }
        
        let forwardButton = StepProgressButton(kind: .forward(selectedColor: .green))
        allButtons.addArrangedSubview(forwardButton)
        
        forwardButton.onPress = { [weak pageView] in
            if pageView?.scrollForward() == false {
                pageView?.progressedSteps.last?.io.finish()
            }
        }
        
        for page in 0..<pageView.pages.arrangedSubviews.count {
            let numButton = StepProgressButton(kind: .page(num: page+1, color: .green, selectedColor: .white))
            numButton.onPress = { [weak pageView] in
                pageView?.scrollTo(page: page)
            }
            pages.addArrangedSubview(numButton)
        }
        
        var lastUnlocked = 0
        for step in pageView.progressedSteps {
            if !step.io.isCanGoNext {
                break
            }
            lastUnlocked += 1
        }
        if pages.arrangedSubviews.count > 1 {
            for button in pages.arrangedSubviews[lastUnlocked+1..<pages.arrangedSubviews.count].flatMap({$0 as? UIControl}) {
                button.isEnabled = false
            }
        }
        for (num, step) in pageView.progressedSteps.enumerated() {
            
            step.io.onChangeCanGoNext = { [weak pageView, weak pages] isCanGoNext in
                guard let pageView = pageView, let pages = pages else {
                    return
                }
                
                var unlocked = isCanGoNext ? num + 1 : num
                pageView.unlockPages(upTo: unlocked+1)
                
                if unlocked >= pages.arrangedSubviews.count {
                    unlocked = pages.arrangedSubviews.count - 1
                }
                
                for button in pages.arrangedSubviews[0...unlocked].flatMap({$0 as? UIControl}) {
                    button.isEnabled = true
                }
                
                for button in pages.arrangedSubviews[unlocked+1..<pages.arrangedSubviews.count].flatMap({$0 as? UIControl}) {
                    button.isEnabled = false
                }
            }
        }
        
        super.init(frame: .zero)
        
        let line = UIView()
        line.translatesAutoresizingMaskIntoConstraints = false
        line.backgroundColor = .white
        addSubview(line)
        addSubview(allButtons)
        addSubview(pages)
        self.pageView = pageView
        
        NSLayoutConstraint.activate([
            allButtons.topAnchor.constraint(equalTo: topAnchor),
            allButtons.bottomAnchor.constraint(equalTo: bottomAnchor),
            allButtons.leftAnchor.constraint(equalTo: leftAnchor),
            allButtons.rightAnchor.constraint(equalTo: rightAnchor),
            heightAnchor.constraint(equalToConstant: 50),
            line.leadingAnchor.constraint(equalTo: allButtons.leadingAnchor, constant: 50-2),
            line.trailingAnchor.constraint(equalTo: allButtons.trailingAnchor, constant: -50+2),
            line.heightAnchor.constraint(equalToConstant: 10),
            line.centerYAnchor.constraint(equalTo: centerYAnchor),
            pages.topAnchor.constraint(equalTo: allButtons.topAnchor),
            pages.bottomAnchor.constraint(equalTo: allButtons.bottomAnchor),
            pages.centerXAnchor.constraint(equalTo: centerXAnchor),
            ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        guard pageView.pages.arrangedSubviews.count > 0 else {
            return
        }
        pageView.didShowPage?(0)
        pageView.progressedSteps.first?.io.didShow()
    }
}
