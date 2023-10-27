//
//  RecommendProductContainerView.swift
//  ZJHome
//
//  Created by Jercan on 2023/10/26.
//

import UIKit

/// 推荐产品View（p2p + 保险）
class RecommendProductContainerView: UIView {
    
    private var p2pProducts = [P2PProductModel]()
    
    private var insureProduct: InsureProductModel?
    
    private lazy var p2pItemView = RecommendP2PProductsView().then {
        $0.collectionView.dataSource = self
        $0.collectionView.onDidSelectIndex = { [weak self] in
            self?.handleClickP2P($0)
        }
        $0.collectionView.onDidEndDecelerating = { [weak self] (i, type) in
            self?.handleEndDecelerating(type, index: i)
        }
    }
    
    private lazy var insureItemView = RecommendInsuranceProductView().then {
        $0.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleClickInsurance)))
    }
    
    private func setupUI(p2pEmpty: Bool, insuranceEmpty: Bool) {
        
        if p2pEmpty, insuranceEmpty {
            refreshWithEmptyState()
            return
        }
        
        else if !p2pEmpty, insuranceEmpty {
            p2pItemView.add(to: self).snp.makeConstraints {
                $0.edges.equalToSuperview()
            }
        }
        else if p2pEmpty, !insuranceEmpty {
            insureItemView.add(to: self).snp.makeConstraints {
                $0.edges.equalToSuperview()
            }
        }
        else if !p2pEmpty, !insuranceEmpty {
            p2pItemView.add(to: self).snp.makeConstraints {
                $0.top.equalToSuperview()
                $0.left.right.equalToSuperview()
            }
            
            insureItemView.add(to: self).snp.makeConstraints {
                $0.top.equalTo(p2pItemView.snp.bottom)
                $0.left.right.equalToSuperview()
                $0.bottom.equalToSuperview()
            }
        }
    }
    
    private func refresh(with model: HomeProductsModel) {
        
        subviews.forEach{ $0.removeFromSuperview() }
        setupUI(p2pEmpty: model.p2pProducts.isEmpty, insuranceEmpty: model.insureProducts.isEmpty)
        
        p2pProducts = model.p2pProducts
//        NotificationCenter.default.post(name: HomePopoverUtil.Notifications.recommendProducts.name, object: !model.p2pProducts.isEmpty)
        
        p2pItemView.collectionView.reloadData()
        if let first = model.insureProducts.first {
            insureProduct = first
            insureItemView.refresh(with: first)
        }
    }
    
    @objc private func handleClickP2P(_ index: Int) {
        
        let data = p2pProducts[index]
//        HomeItemEvent(type: .recommendProducts, data: data).post(by: self)
    }
    
    @objc private func handleClickInsurance() {
        
        if let data = insureProduct {
//            HomeItemEvent(type: .recommendProducts, data: data).post(by: self)
        }
    }
    
    private func handleEndDecelerating(_ type: UIScrollView.PageBehaviorOnEndDecelerating, index: Int) {
        
        guard (0 ..< p2pProducts.count).contains(index) else { return }
        let model = p2pProducts[index]
        switch type {
        case .staySame: break
        case .increased: break
        case .decreased: break
        }
    }
}

extension RecommendProductContainerView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return p2pProducts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: RecommendP2PProductCell = collectionView.dequeueReuseableCell(forIndexPath: indexPath)
        cell.refresh(with: p2pProducts[indexPath.item])
        cell.startProgressAnimation()
        return cell
    }
}

extension RecommendProductContainerView: HomeRefreshableItemView {
    
    func refresh(with state: HomeItemState<HomeProductsModel>) {
        
        switch state {
        case .loading:
            refreshWithLoadingState()
        case .data(let model):
            refresh(with: model)
        case .empty:
            refreshWithEmptyState()
//            NotificationCenter.default.post(name: HomePopoverUtil.Notifications.recommendProducts.name, object: false)
        }
    }
}
