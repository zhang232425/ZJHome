//
//  HomeScrollView.swift
//  Action
//
//  Created by Jercan on 2022/10/18.
//

import UIKit

class HomeScrollView: UIScrollView {

    enum State {
        case loading
        case layout([HomeLayoutModel.SectionModel])
        case failure
    }
    
    var refreshClick: (() -> ())? {
        get { failureView.refreshBlock }
        set { failureView.refreshBlock = newValue }
    }
    
    // MARK: - Lazy Load
    private(set) lazy var stackView = UIStackView().then {
        $0.axis = .vertical       // 排列方向
        $0.spacing = 0            // 子视图间距
        $0.distribution = .fill   // 布局规则
        $0.alignment = .fill      // 对齐方式
    }
    
    private lazy var failureView = HomeFailureView()
    
}

extension HomeScrollView {
    
    func setState(_ state: HomeScrollView.State) {
        
        switch state {
        case .loading:
            setFailureState(false)
            setupViews()
        case .layout(let sections):
            setFailureState(false)
            resetLayout(sections)
        case .failure:
            setFailureState(true)
        }
                        
    }
    
}

private extension HomeScrollView {
    
    func setupViews() {
        
        func setupPlaceholderViews(heightUsed: CGFloat) {
            let remainH = bounds.height - heightUsed
            let count = Int(ceil(remainH / HomeItemPlaceholderView.defaultHeight))
            for _ in 0 ..< count {
                let view = HomeItemPlaceholderView()
                stackView.addArrangedSubview(view)
                view.snp.makeConstraints {
                    $0.left.right.equalToSuperview()
                }
            }
        }
        
        stackView.arrangedSubviews.forEach {
            stackView.removeArrangedSubview($0)
            $0.removeFromSuperview()
        }
        
        let sub = QuickEntryView()
        appendSubview(sub)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.02) {
            setupPlaceholderViews(heightUsed: sub.bounds.height)
        }
        
        
    }
    
    func setFailureState(_ isFailed: Bool) {
        
        if isFailed {
            stackView.removeFromSuperview()
            failureView.add(to: self).snp.makeConstraints {
                $0.edges.equalToSuperview()
                $0.width.height.equalToSuperview()
            }
        } else {
            failureView.removeFromSuperview()
            stackView.add(to: self).snp.makeConstraints {
                $0.edges.equalToSuperview()
                $0.width.equalToSuperview()
            }
        }
        
    }
    
    func resetLayout(_ sections: [HomeLayoutModel.SectionModel]) {
        
        guard !sections.isEmpty else { return }
        
        let types = sections.compactMap { $0.type.homeItemType } + [.brandLogo]
        
        stackView.arrangedSubviews.forEach {
            stackView.removeArrangedSubview($0)
            $0.removeFromSuperview()
        }
        
        types.forEach {
            let sub = $0.viewClass.init()
            appendSubview(sub)
        }
        
        
    }
    
}

extension HomeScrollView {
    
    func appendSubview(_ sub: UIView) {
        
        stackView.addArrangedSubview(sub)
        sub.snp.makeConstraints {
            $0.left.right.equalToSuperview()
        }
    
    }
    
}
