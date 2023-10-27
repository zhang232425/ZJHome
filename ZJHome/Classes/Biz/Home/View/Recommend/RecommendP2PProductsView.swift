//
//  RecommendP2PProductsView.swift
//  ZJHome
//
//  Created by Jercan on 2023/10/26.
//

import UIKit
import ZJExtension
import DeviceKit

class RecommendP2PProductsView: UIView {
    
    private lazy var titleLabel = UILabel().then {
        $0.textColor = UIColor(hexString: "#2B3033")
        $0.font = UIFont.bold20
        $0.adjustsFontSizeToFitWidth = true
        $0.text = Locale.homeSectionNameRecommendP2P.localized
    }
    
    private lazy var imageView = UIImageView().then {
        $0.image = UIImage.dd.named("home_item_more_icon")
    }
    
    private(set) lazy var collectionView = HomeCollectionView(frame: .zero, collectionViewLayout: .init()).then {
        $0.clipsToBounds = false
        $0.registerCell(RecommendP2PProductCell.self)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

private extension RecommendP2PProductsView {
    
    func setupViews() {
        
        UIView().then {
            $0.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleClickTitle)))
        }.add(to: self).snp.makeConstraints {
            $0.top.left.right.equalToSuperview()
            $0.height.equalTo(HomeScrollView.sharedItemTopMargin + 24 + 14)
        }
        
        titleLabel.add(to: self).snp.makeConstraints {
            $0.top.equalTo(HomeScrollView.sharedItemTopMargin)
            $0.left.equalTo(16)
            $0.right.equalTo(-50)
        }
        
        imageView.add(to: self).snp.makeConstraints {
            $0.right.equalToSuperview().inset(16)
            $0.size.equalTo(16)
            $0.centerY.equalTo(titleLabel)
        }
        
        collectionView.add(to: self).snp.makeConstraints {
            $0.left.equalTo(16)
            $0.right.equalTo(-36)
            $0.top.equalTo(titleLabel.snp.bottom).offset(14)
            $0.height.equalTo((Device.current.diagonal <= 4) ? 127 : 112)
            $0.bottom.equalTo(-HomeScrollView.sharedItemBottomMargin)
        }
        
        
    }
    
    @objc func handleClickTitle() {
        
        HomeExtraEvent.moreProduct.post(by: self)
        
    }
    
}
