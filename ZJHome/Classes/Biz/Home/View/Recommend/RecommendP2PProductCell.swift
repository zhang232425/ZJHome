//
//  RecommendP2PProductCell.swift
//  ZJHome
//
//  Created by Jercan on 2023/10/26.
//

import UIKit
import DeviceKit
import ZJLoginManager

class RecommendP2PProductCell: UICollectionViewCell {

    private lazy var borderView = UIView().then {
        $0.layer.cornerRadius = 4
        $0.layer.masksToBounds = true
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor(hexString: "#F0F0F0").cgColor
    }
    
    private lazy var tagView = ProductCellTopTagView()
    
    private lazy var percentLabel = UILabel().then {
        $0.textColor = UIColor(hexString: "#FF7D0F")
        $0.font = UIFont.bold30
        $0.textAlignment = .center
    }
    
    private lazy var raiseRateLabel = UILabel().then {
        $0.textColor = UIColor(hexString: "#FF7D0F")
        $0.backgroundColor = UIColor(hexString: "#FF7D0F", alpha: 0.1)
        $0.font = UIFont.regular14
        $0.textAlignment = .center
        $0.layer.cornerRadius = 3
        $0.layer.masksToBounds = true
        $0.isHidden = true
    }
    
    private lazy var titleLabel = UILabel().then {
        $0.textColor = UIColor(hexString: "#333333")
        $0.font = UIFont.medium14
        $0.numberOfLines = 1
    }

    private lazy var progressView = GIFProgressView().then {
        $0.colorStyle = .orange
    }
    
    private lazy var amountLabel = UILabel().then {
        $0.textColor = UIColor(hexString: "#999999")
        $0.font = UIFont.regular12
        if Device.current.diagonal <= 4 {
            $0.numberOfLines = 2
        } else {
            $0.adjustsFontSizeToFitWidth = true
        }
    }

    private lazy var timeLabel = UILabel().then {
        $0.textColor = UIColor(hexString: "#333333")
        $0.font = UIFont.medium14
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

private extension RecommendP2PProductCell {
    
    func setupViews() {
        
        borderView.add(to: contentView).snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        tagView.add(to: contentView).snp.makeConstraints {
            $0.top.left.equalToSuperview()
            $0.right.lessThanOrEqualToSuperview()
        }
    
        percentLabel.add(to: contentView).snp.makeConstraints {
            $0.left.equalToSuperview()
            $0.centerY.equalToSuperview()
            $0.width.equalToSuperview().multipliedBy(0.413)
        }
    
        raiseRateLabel.add(to: contentView).snp.makeConstraints {
            $0.top.equalTo(percentLabel.snp.bottom).offset(2)
            $0.width.equalTo(62)
            $0.height.equalTo(18)
            $0.centerX.equalTo(percentLabel.snp.centerX)
        }
        
        titleLabel.add(to: contentView).snp.makeConstraints {
            $0.top.equalTo(16)
            $0.left.equalTo(percentLabel.snp.right)
            $0.right.equalTo(-8)
        }
        
        progressView.add(to: contentView).snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(13)
            $0.left.equalTo(percentLabel.snp.right)
            $0.right.equalTo(-12)
            $0.height.equalTo(4)
        }
        
        amountLabel.add(to: contentView).snp.makeConstraints {
            $0.top.equalTo(progressView.snp.bottom).offset(11)
            $0.left.equalTo(percentLabel.snp.right)
            $0.right.equalTo(-8)
        }
        
        timeLabel.add(to: contentView).snp.makeConstraints {
            $0.top.equalTo(amountLabel.snp.bottom).offset(8)
            $0.left.equalTo(percentLabel.snp.right)
            $0.right.equalToSuperview().inset(8)
        }
        
    }
    
}

extension RecommendP2PProductCell {
    
    func refresh(with model: P2PProductModel) {
        
        tagView.setText(model.label)
        percentLabel.attributedText = HomeTextUIAdapter.rateAttributedString(rate: model.rate)
        if model.raiseInterestRate > 0 {
            raiseRateLabel.isHidden = false
            percentLabel.snp.updateConstraints {
                $0.centerY.equalToSuperview().offset(-10)
            }
            raiseRateLabel.text = String(format: "%+.1f%%", model.raiseInterestRate)
        }else {
            raiseRateLabel.isHidden = true
            percentLabel.snp.updateConstraints {
                $0.centerY.equalToSuperview().offset(0)
            }
            raiseRateLabel.text = nil
        }
        if ZJLoginManager.shared.isLogin {
            titleLabel.text = model.name
        } else {
            titleLabel.text = model.name.count > 16 ? String(model.name.prefix(16)) + "..." : model.name
        }
        progressView.progress = model.progress
        amountLabel.text = model.remainDescription
        timeLabel.text = ZJLoginManager.shared.isLogin ? model.periodDescription : Locale.viewMore.localized
        
    }
    
    func startProgressAnimation() {
        progressView.startGIFAnimating()
    }
    
}
