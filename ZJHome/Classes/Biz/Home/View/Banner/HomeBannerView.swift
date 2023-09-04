//
//  HomeBannerView.swift
//  Action
//
//  Created by Jercan on 2023/8/31.
//

import UIKit

class HomeBannerView: BaseView {
    
    private var models = [HomeBannerModel]()
    
    private lazy var bannerView = CommonBannerView().then {
        $0.imageViewContentMode = .scaleAspectFill
        $0.layer.cornerRadius = 4
        $0.layer.masksToBounds = true
    }

    override func initialize() {
        setupViews()
    }
    
}

private extension HomeBannerView {
    
    func setupViews() {
        
        bannerView.add(to: self).snp.makeConstraints {
            $0.top.equalToSuperview().inset(10)
            $0.left.right.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview().inset(10)
        }
        
    }
    
    func refresh(with models: [HomeBannerModel]) {
        
        guard !models.isEmpty else { return }
        
        subviews.forEach{ $0.removeFromSuperview() }
        setupViews()
        
        self.models = models
        bannerView.imageUrls = models.map{ $0.imageUrl }
        
    }
    
}

extension HomeBannerView: HomeRefreshableItemView {
    
    func refresh(with state: HomeItemState<[HomeBannerModel]>) {
        
        switch state {
        case .loading:
            refreshWithLoadingState()
        case .data(let list):
            if list.isEmpty {
                refreshWithEmptyState()
            } else {
                refresh(with: list)
            }
        case .empty:
            refreshWithEmptyState()
        }
        
    }
    
}
