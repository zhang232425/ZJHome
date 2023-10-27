//
//  NoviceProductHorizontalItemView.swift
//  ZJHome
//
//  Created by Jercan on 2023/10/25.
//

import UIKit
import ZJLoginManager

/// 新手专区产品横版ItemView
class NoviceProductHorizontalItemView: UIView {
    
    private lazy var percentLabel = UILabel().then {
        $0.textAlignment = .center
        $0.textColor = .init(hexString: "#FF7D0F")
        $0.font = .systemFont(ofSize: 34, weight: .bold)
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
    }
    
    private lazy var bottomLabel = UILabel().then {
        $0.textColor = .init(hexString: "#333333")
        $0.font = .systemFont(ofSize: 14, weight: .medium)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) { fatalError() }
    
    private func setupUI() {
        
        titleLabel.add(to: self).snp.makeConstraints {
            $0.right.equalTo(-12)
            $0.top.equalTo(16)
            $0.width.equalToSuperview().multipliedBy(0.585)
        }
        
        progressView.add(to: self).snp.makeConstraints {
            $0.left.equalTo(titleLabel)
            $0.right.equalTo(-12)
            $0.top.equalTo(titleLabel.snp.bottom).offset(12)
            $0.height.equalTo(4)
        }
        
        detailLabel.add(to: self).snp.makeConstraints {
            $0.left.equalTo(titleLabel)
            $0.right.equalTo(-12)
            $0.top.equalTo(progressView.snp.bottom).offset(11)
        }
        
        bottomLabel.add(to: self).snp.makeConstraints {
            $0.left.equalTo(titleLabel)
            $0.right.equalTo(-12)
            $0.top.equalTo(detailLabel.snp.bottom).offset(8)
            $0.bottom.equalTo(-16)
        }
        
        imageView.add(to: self).snp.makeConstraints {
            $0.left.equalTo(6)
            $0.right.equalTo(titleLabel.snp.left).offset(-16)
            $0.height.equalTo(imageView.snp.width).multipliedBy(0.745)
            $0.centerY.equalToSuperview()
        }
        
        percentLabel.add(to: self).snp.makeConstraints {
            $0.left.equalToSuperview()
            $0.right.equalTo(titleLabel.snp.left)
            $0.centerY.equalToSuperview()
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
        percentLabel.attributedText = HomeTextUIAdapter.rateAttributedString(rate: model.rate)
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
