//
//  NoviceProductVerticalItemView.swift
//  ZJHome
//
//  Created by Jercan on 2023/10/25.
//

import UIKit
import ZJLoginManager

/// 新手专区产品竖版ItemView
class NoviceProductVerticalItemView: UIView {
    
    private lazy var percentLabel = UILabel().then {
        $0.textColor = .init(hexString: "#FF7D0F")
        $0.textAlignment = .center
        $0.font = .systemFont(ofSize: 40, weight: .bold)
    }
    
    private lazy var imageView = UIImageView()
    
    private lazy var titleLabel = UILabel().then {
        $0.textColor = .init(hexString: "#333333")
        $0.font = .systemFont(ofSize: 14, weight: .medium)
        $0.numberOfLines = 2
    }
    
    private lazy var progressView = GIFProgressView().then {
        $0.colorStyle = .yellow
        $0.progressColor = .init(hexString: "#FFD23E")
    }
    
    private lazy var detailLabel = UILabel().then {
        $0.textColor = .init(hexString: "#999999")
        $0.font = .systemFont(ofSize: 12, weight: .regular)
        $0.adjustsFontSizeToFitWidth = true
        $0.minimumScaleFactor = 0.8
        $0.numberOfLines = 1
    }
    
    private lazy var bottomLabel = UILabel().then {
        $0.textColor = .init(hexString: "#333333")
        $0.font = .systemFont(ofSize: 14, weight: .medium)
        $0.numberOfLines = 2
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) { fatalError() }
    
    private func setupUI() {
        
        imageView.add(to: self).snp.makeConstraints {
            $0.top.equalTo(3)
            $0.centerX.equalToSuperview()
            $0.width.equalToSuperview().multipliedBy(0.638)
            $0.height.equalTo(imageView.snp.width).multipliedBy(0.745)
        }
        
        percentLabel.add(to: self).snp.makeConstraints {
            $0.left.right.equalToSuperview()
            $0.height.centerY.equalTo(imageView)
        }
        
        titleLabel.add(to: self).snp.makeConstraints {
            $0.left.equalTo(12)
            $0.right.equalTo(-12)
            $0.top.equalTo(imageView.snp.bottom).offset(6)
        }
        
        progressView.add(to: self).snp.makeConstraints {
            $0.left.equalTo(12)
            $0.right.equalTo(-12)
            $0.top.equalTo(titleLabel).offset(48)
            $0.height.equalTo(4)
        }
        
        detailLabel.add(to: self).snp.makeConstraints {
            $0.left.equalTo(12)
            $0.right.equalTo(-12)
            $0.top.equalTo(progressView.snp.bottom).offset(11)
        }
        
        bottomLabel.add(to: self).snp.makeConstraints {
            $0.left.equalTo(12)
            $0.right.equalTo(-12)
            $0.top.equalTo(detailLabel.snp.bottom).offset(8)
            $0.bottom.equalTo(-16)
        }
    }
    
    func refresh(with model: InsureProductModel, tag: String) {
        
        imageView.setImageWith(url: model.imageUrl, placeholderImage: nil)
        percentLabel.text = nil
        titleLabel.attributedText = HomeTextUIAdapter.noviceViewTitle(tag: tag, text: model.name)
        progressView.progress = model.progress
        detailLabel.text = model.remainDesc
        bottomLabel.text = "Rp 0" // 免费险
    }
    
    func refresh(with model: P2PProductModel, tag: String) {
        
        imageView.image = nil
        if model.raiseInterestRate > 0 {
            percentLabel.attributedText = HomeTextUIAdapter.raiseRateAttributedString(rate: model.rate, raiseRate: model.raiseInterestRate)
        } else {
            percentLabel.attributedText = HomeTextUIAdapter.rateAttributedString(rate: model.rate)
        }
        if ZJLoginManager.shared.isLogin {
            titleLabel.attributedText = HomeTextUIAdapter.noviceViewTitle(tag: tag, text: model.name)
        } else {
            titleLabel.attributedText = HomeTextUIAdapter.noviceViewTitle(tag: tag, text: (model.name.count > 16) ? String(model.name.prefix(16)) + "..." : model.name)
        }
        progressView.progress = model.progress
        detailLabel.text = model.remainDescription
        bottomLabel.text = ZJLoginManager.shared.isLogin ? model.periodDescription : Locale.viewMore.localized
    }
}
