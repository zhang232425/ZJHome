//
//  NoviceProductContainerView.swift
//  ZJHome
//
//  Created by Jercan on 2023/10/24.
//

import UIKit

/// 新手产品View
class NoviceProductContainerView: UIView {
    
    fileprivate enum DataLayout {
        case double(leftInsurance: InsureProductModel, rightP2P: P2PProductModel)
        case singleInsurance(InsureProductModel)
        case singleP2P(P2PProductModel)
    }
    
    private var dataLayout: DataLayout?
    
    private lazy var titleLabel = UILabel().then {
        $0.textColor = .init(hexString: "#333333")
        $0.font = .systemFont(ofSize: 20, weight: .bold)
        $0.adjustsFontSizeToFitWidth = true
    }
    
    private lazy var horizontalView = NoviceProductHorizontalItemView().then {
        self.applyCommonStyle($0)
    }
    
    private lazy var leftView = NoviceProductVerticalItemView().then { // 左边的，固定显示保险
        self.applyCommonStyle($0)
    }
    
    private lazy var rightView = NoviceProductVerticalItemView().then { // 右边的，固定显示P2P
        self.applyCommonStyle($0)
    }
    
    private func applyCommonStyle(_ view: UIView) {
        view.layer.cornerRadius = 4
        view.layer.masksToBounds = true
        view.layer.borderColor = UIColor(hexString: "#F0F0F0").cgColor
        view.layer.borderWidth = 1
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap)))
    }
    
    private func configSingleLayout() {
        
        subviews.forEach{ $0.removeFromSuperview() }
        
        titleLabel.add(to: self).snp.makeConstraints {
            $0.top.equalTo(HomeScrollView.sharedItemTopMargin)
            $0.left.right.equalToSuperview().inset(16)
        }
        
        horizontalView.add(to: self).snp.makeConstraints {
            $0.left.right.equalToSuperview().inset(16)
            $0.top.equalTo(titleLabel.snp.bottom).offset(14)
            $0.bottom.equalTo(-HomeScrollView.sharedItemBottomMargin)
        }
    }
    
    private func configDoubleLayout() {
        
        subviews.forEach{ $0.removeFromSuperview() }
        
        titleLabel.add(to: self).snp.makeConstraints {
            $0.top.equalTo(HomeScrollView.sharedItemTopMargin)
            $0.left.right.equalToSuperview().inset(16)
        }
        
        leftView.add(to: self).snp.makeConstraints {
            $0.left.equalTo(16)
            $0.right.equalTo(snp.centerX).offset(-4)
            $0.top.equalTo(titleLabel.snp.bottom).offset(14)
            $0.bottom.equalTo(-HomeScrollView.sharedItemBottomMargin)
        }
        
        rightView.add(to: self).snp.makeConstraints {
            $0.right.equalTo(-16)
            $0.left.equalTo(snp.centerX).offset(4)
            $0.top.equalTo(titleLabel.snp.bottom).offset(14)
            $0.bottom.equalTo(-HomeScrollView.sharedItemBottomMargin)
        }
    }
    
    private func refresh(with model: HomeProductsModel) {
        
        subviews.forEach{ $0.removeFromSuperview() }
        
        if model.p2pProducts.count >= 1, model.insureProducts.count >= 1 {
            configDoubleLayout()
            leftView.refresh(with: model.insureProducts[0], tag: model.insureTagText)
            rightView.refresh(with: model.p2pProducts[0], tag: model.p2pTagText)
            dataLayout = .double(leftInsurance: model.insureProducts[0], rightP2P: model.p2pProducts[0])
        } else {
            configSingleLayout()
            if let m = model.p2pProducts.first {
                horizontalView.refresh(with: m, tag: model.p2pTagText)
                dataLayout = .singleP2P(m)
            }
            else if let m = model.insureProducts.first {
                horizontalView.refresh(with: m, tag: model.insureTagText)
                dataLayout = .singleInsurance(m)
            }
        }
    }
    
    @objc private func handleTap(_ tap: UITapGestureRecognizer) {
        
        guard let data = dataLayout else { return }
        switch data {
        case .double(let leftInsurance, let rightP2P):
            if tap.view === leftView {
                HomeItemEvent(type: .noviceProducts, data: leftInsurance).post(by: self)
            } else if tap.view === rightView {
                HomeItemEvent(type: .noviceProducts, data: rightP2P).post(by: self)
            }
        case .singleInsurance(let model):
            HomeItemEvent(type: .noviceProducts, data: model).post(by: self)
        case .singleP2P(let model):
            HomeItemEvent(type: .noviceProducts, data: model).post(by: self)
        }
    }
}

extension NoviceProductContainerView: HomeRefreshableItemView {
    
    func refresh(with state: HomeItemState<HomeProductsModel>) {
        
        switch state {
        case .loading:
            refreshWithLoadingState()
        case .data(let model):
            if model.p2pProducts.isEmpty, model.insureProducts.isEmpty {
                refreshWithEmptyState()
//                NotificationCenter.default.post(name: HomePopoverUtil.Notifications.noviceProducts.name, object: false)
            }else {
                refresh(with: model)
//                NotificationCenter.default.post(name: HomePopoverUtil.Notifications.noviceProducts.name, object: true)
            }
        case .empty:
            refreshWithEmptyState()
//            NotificationCenter.default.post(name: HomePopoverUtil.Notifications.noviceProducts.name, object: false)
        }
    }
}

extension NoviceProductContainerView: HomeTitledItemView {
    
    func setTitle(_ title: String?) {
        titleLabel.text = title
    }
}
