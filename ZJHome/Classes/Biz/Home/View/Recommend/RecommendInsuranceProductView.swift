//
//  RecommendInsuranceProductView.swift
//  ZJHome
//
//  Created by Jercan on 2023/10/26.
//

import UIKit

class RecommendInsuranceProductView: UIView {
    
    private lazy var titleLabel = UILabel().then {
        $0.textColor = .init(hexString: "#2B3033")
        $0.font = .systemFont(ofSize: 20, weight: .bold)
        $0.adjustsFontSizeToFitWidth = true
        $0.text = Locale.homeSectionNameRecommendInsurance.localized
    }
    
    private lazy var itemView = ItemView().then {
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor(hexString: "#F0F0F0").cgColor
        $0.layer.cornerRadius = 4
        $0.layer.masksToBounds = true
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) { fatalError() }
    
    private func setupUI() {
        
        titleLabel.add(to: self).snp.makeConstraints {
            $0.top.equalTo(HomeScrollView.sharedItemTopMargin)
            $0.left.equalTo(16)
            $0.right.equalTo(-16)
        }
        
        itemView.add(to: self).snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(14)
            $0.left.equalTo(16)
            $0.right.equalTo(-16)
            $0.bottom.equalTo(-HomeScrollView.sharedItemBottomMargin)
        }
    }
    
    func refresh(with model: InsureProductModel) {
        
        itemView.imageView.setImageWith(url: model.imageUrl, placeholderImage: nil)
        itemView.titleLabel.text = model.name
        itemView.detailLabel.text = model.detailDescription
        itemView.amountLabel.text = Locale.insureAmountPrefix.localized + " " + model.priceDescription
    }
}

fileprivate class ItemView: UIView {
    
    private(set) lazy var tagView = UIView().then {
        $0.backgroundColor = .yellow
    }
    
    private(set) lazy var imageView = UIImageView().then {
        $0.layer.cornerRadius = 4
        $0.layer.masksToBounds = true
    }
    
    private(set) lazy var titleLabel = UILabel().then {
        $0.textColor = .init(hexString: "#333333")
        $0.font = .systemFont(ofSize: 14, weight: .medium)
        $0.numberOfLines = 1
    }
    
    private(set) lazy var detailLabel = UILabel().then {
        $0.textColor = .init(hexString: "#999999")
        $0.font = .systemFont(ofSize: 12, weight: .regular)
        $0.numberOfLines = 2
    }
    
    private(set) lazy var amountLabel = UILabel().then {
        $0.textColor = .init(hexString: "#FF7D0F")
        $0.font = .systemFont(ofSize: 14, weight: .medium)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) { fatalError() }
    
    private func setupUI() {
        
        tagView.add(to: self).snp.makeConstraints {
            $0.left.top.equalToSuperview()
        }
        
        titleLabel.add(to: self).snp.makeConstraints {
            $0.top.equalTo(16)
            $0.left.equalTo(snp.right).multipliedBy(0.378)
            $0.right.equalTo(-12)
        }
        
        detailLabel.add(to: self).snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(8)
            $0.left.equalTo(titleLabel)
            $0.right.equalTo(-12)
        }
        
        amountLabel.add(to: self).snp.makeConstraints {
            $0.top.equalTo(detailLabel.snp.bottom).offset(8)
            $0.left.equalTo(titleLabel)
            $0.right.equalTo(-12)
            $0.bottom.equalTo(-16)
        }
        
        imageView.add(to: self).snp.makeConstraints {
            $0.left.equalTo(12)
            $0.right.equalTo(titleLabel.snp.left).offset(-12)
            $0.centerY.equalToSuperview()
            $0.height.equalTo(imageView.snp.width).multipliedBy(0.92)
        }
    }
}
