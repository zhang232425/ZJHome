//
//  ProcessGuidingView.swift
//  ZJHome
//
//  Created by Jercan on 2023/6/15.
//

import UIKit
import ZJExtension

/// 流程引导View
class ProcessGuidingView: UIView {
    
    private var models = [HomeGuidingModel]()
    
    private lazy var titleLabel = UILabel().then {
        $0.textColor = .init(hexString: "#2B3033")
        $0.font = .boldSystemFont(ofSize: 20)
        $0.adjustsFontSizeToFitWidth = true
    }
    
    private lazy var currentStepLabel = UILabel().then {
        $0.textColor = .init(hexString: "#2B3033")
        $0.font = .systemFont(ofSize: 16, weight: .medium)
        $0.text = "1"
    }
    
    private lazy var sumStepLabel = UILabel().then {
        $0.textColor = .init(hexString: "#999999")
        $0.font = .systemFont(ofSize: 12, weight: .medium)
        $0.text = "/-"
    }
    
    
    private(set) lazy var collectionView = ProcessGuidingCollectionView(frame: .zero, collectionViewLayout: .init()).then {
        $0.backgroundColor = .white
        $0.dataSource = self
        $0.registerCell(ProcessGuidingCell.self)
        $0.showsHorizontalScrollIndicator = false
        $0.onDidEndDecelerating = { [weak self] (i, type) in
            self?.currentStepLabel.text = (i + 1).description
        }
    }
    
}


private extension ProcessGuidingView {
    
    func setupViews() {
        
        self.backgroundColor = .white
        
        titleLabel.add(to: self).snp.makeConstraints {
            $0.top.equalTo(10)
            $0.left.equalTo(16)
            $0.right.equalTo(-50)
        }
        
        sumStepLabel.add(to: self).snp.makeConstraints {
            $0.right.equalTo(-16)
            $0.lastBaseline.equalTo(titleLabel)
        }
        
        currentStepLabel.add(to: self).snp.makeConstraints {
            $0.right.equalTo(sumStepLabel.snp.left)
            $0.lastBaseline.equalTo(titleLabel)
        }
        
        collectionView.add(to: self).snp.makeConstraints {
            $0.left.equalTo(16)
            $0.top.equalTo(titleLabel.snp.bottom).offset(14)
            $0.right.equalTo(-16)
            $0.height.equalTo(112)
            $0.bottom.equalTo(-12)
        }
        
    }
    
    
    
    func refresh(with models: [HomeGuidingModel]) {
        
        guard !models.isEmpty else { return }
        
        setupViews()
        
        self.models = models
        
        sumStepLabel.text = "/\(models.count)"
        titleLabel.text = Locale.guideHeaderName.localized
        
        collectionView.reloadData()
        
    }
    
}

extension ProcessGuidingView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return models.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: ProcessGuidingCell = collectionView.dequeueReuseableCell(forIndexPath: indexPath)
        cell.refresh(with: models[indexPath.item])
        return cell
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

