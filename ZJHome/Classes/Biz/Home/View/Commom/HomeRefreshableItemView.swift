//
//  HomeRefreshableItemView.swift
//  ZJHome
//
//  Created by Jercan on 2023/6/15.
//

import Foundation

protocol HomeTitledItemView {
    func setTitle(_ title: String?)
}

protocol HomeItemLoadingSataeHandling {
    func refreshWithLoadingState()
}

protocol HomeItemEmptyStateHandling {
    func refreshWithEmptyState()
}

extension HomeItemLoadingSataeHandling where Self: UIView {
    
    func refreshWithLoadingState() {
        
        subviews.forEach { $0.removeFromSuperview() }
        let placeholder = HomeItemPlaceholderView()
        placeholder.add(to: self).snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
    }
    
}

extension HomeItemEmptyStateHandling where Self: UIView {
    
    func refreshWithEmptyState() {
        
        subviews.forEach { $0.removeFromSuperview() }
        let emptyView = UIView()
        emptyView.add(to: self).snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.height.equalTo(0)
        }
        
    }
    
}

protocol HomeRefreshableItemView: HomeItemLoadingSataeHandling, HomeItemEmptyStateHandling {}

