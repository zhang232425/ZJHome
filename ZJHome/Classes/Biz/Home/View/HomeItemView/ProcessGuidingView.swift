//
//  ProcessGuidingView.swift
//  ZJHome
//
//  Created by Jercan on 2023/6/15.
//

import UIKit

/// 流程引导View
class ProcessGuidingView: BaseView {
    
    private var models = [HomeGuidingModel]()
    
    private lazy var titleLabel = UILabel().then {
        $0.textColor = .init(hexString: "#2B3033")
        $0.font = .systemFont(ofSize: 20, weight: .bold)
        $0.adjustsFontSizeToFitWidth = true
    }
    
    private lazy var currentStepLabel = UILabel().then {
        $0.textColor = .init(hexString: "#2B3033")
        $0.font = .systemFont(ofSize: 16, weight: .medium)
        $0.text = "-"
    }
    
    private lazy var sumStepLabel = UILabel().then {
        $0.textColor = .init(hexString: "#999999")
        $0.font = .systemFont(ofSize: 12, weight: .medium)
        $0.text = " /-"
    }
    
    override func initialize() {
        
        
        
    }
    
    
}

private extension ProcessGuidingView {
    
    func refresh(with models: [HomeGuidingModel]) {
        
        print("models ===== \(models)")
        
    }
    
}


extension ProcessGuidingView: HomeRefreshableItemView {
    
    func refresh(with state: HomeItemState<[HomeGuidingModel]>) {
        
        switch state {
        case .loading:
            refreshWithLoadingState()
        case .data(let list):
            if list.isEmpty {
                refreshWithEmptyState()
//                NotificationCenter.default.post(name: HomePopoverUtil.Notifications.taskGuide.name, object: false)
            } else {
                refresh(with: list)
//                NotificationCenter.default.post(name: HomePopoverUtil.Notifications.taskGuide.name, object: true)
            }
        case .empty:
            refreshWithEmptyState()
//            NotificationCenter.default.post(name: HomePopoverUtil.Notifications.taskGuide.name, object: false)
        }
        
    }
}

