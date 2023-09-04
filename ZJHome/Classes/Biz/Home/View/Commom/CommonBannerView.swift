//
//  CommonBannerView.swift
//  ZJHome
//
//  Created by Jercan on 2023/8/31.
//

import UIKit
import SDCycleScrollView

class CommonBannerView: BaseView {
    
    var imageViewContentMode: ContentMode {
        get { bannerView.bannerImageViewContentMode }
        set { bannerView.bannerImageViewContentMode = newValue }
    }
    
    /// compactMap
    var imageUrls: [String] {
        get {
            bannerView.imageURLStringsGroup.compactMap { $0 as? String }
        }
        set {
            bannerView.imageURLStringsGroup = newValue
            pageControl.numberOfPages = newValue.count
        }
    }
    
    private lazy var pageControl = PageControl()
    
    private lazy var bannerView = SDCycleScrollView().then {
        $0.backgroundColor = .white
        $0.autoScrollTimeInterval = 3
        $0.showPageControl = false
        $0.placeholderImage = UIImage.dd.named("home_banner_placeholder")
//        $0.itemDidScrollOperationBlock = { [weak self] in
//            self.
//        }
    }

    override func initialize() {
        setupViews()
    }
    
}

private extension CommonBannerView {
    
    func setupViews() {
        
        bannerView.add(to: self).snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.height.equalTo(bannerView.snp.width).multipliedBy(0.329)
        }
        
        pageControl.add(to: self).snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(6)
            $0.centerX.equalTo(bannerView)
        }
        
    }
    
}

fileprivate class PageControl: UIStackView {
    
    var numberOfPages = 0 {
        didSet {
            reset()
            refresh()
        }
    }
    
    var currentPage = 0 {
        didSet {
            refresh()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        axis = .horizontal
        spacing = 4
        distribution = .fill
        alignment = .fill
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func reset() {
    
        arrangedSubviews.forEach {
            removeArrangedSubview($0)
            $0.removeFromSuperview()
        }
        
        for _ in 0 ..< numberOfPages {
            let dotView = DotView()
            addArrangedSubview(dotView)
            dotView.snp.makeConstraints {
                $0.top.bottom.equalToSuperview()
                $0.size.equalTo(dotView.normalSize)
            }
        }
                
    }
    
    private func refresh() {
        
        guard (0 ..< numberOfPages).contains(currentPage) else { return }
        
        arrangedSubviews.forEach {
            let dotView = $0 as? DotView
            dotView?.changeActiveState(false)
        }
        
        let dotView = arrangedSubviews[currentPage] as? DotView
        dotView?.changeActiveState(true)
        
    }
    
}

fileprivate class DotView: UIView {
    
    let normalSize = CGSize(width: 8, height: 3)
    
    private let activeSize = CGSize(width: 16, height: 3)
    
    func changeActiveState(_ active: Bool) {
        switch active {
        case true:
            backgroundColor = .white
            snp.updateConstraints {
                $0.size.equalTo(activeSize)
            }
        case false:
            backgroundColor = UIColor.white.withAlphaComponent(0.5)
            snp.updateConstraints {
                $0.size.equalTo(normalSize)
            }
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = bounds.height / 2
        layer.masksToBounds = true
    }
    
}


