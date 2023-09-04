//
//  ProcessGuidingCell.swift
//  ZJHome
//
//  Created by Jercan on 2023/8/22.
//

import UIKit
import ZJCommonView
import ZJExtension

class ProcessGuidingCell: UICollectionViewCell {
    
    private lazy var containerView = RoundCornerView(radius: 5).then {
        $0.backgroundColor = UIColor(hexString: "#F5F5F5")
//        $0.corners = [.topRight, .topLeft]
    }
    
    private lazy var titleLabel = UILabel().then {
        $0.textColor = UIColor(hexString: "#333333")
        $0.numberOfLines = 0
        $0.adjustsFontSizeToFitWidth = true
    }
    
    private lazy var imageView = UIImageView()
    
    private lazy var button = UIButton(type: .custom).then {
        $0.layer.cornerRadius = 12
        $0.layer.masksToBounds = true
        $0.backgroundColor = UIColor(hexString: "#FF7D0F")
        $0.titleLabel?.adjustsFontSizeToFitWidth = true
        $0.titleLabel?.font = .medium12
        $0.contentEdgeInsets = .init(top: 5, left: 12, bottom: 5, right: 12)
        $0.setTitleColor(UIColor.white.withAlphaComponent(0.5), for: .highlighted)
        $0.addTarget(self, action: #selector(handleClick), for: .touchUpInside)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

private extension ProcessGuidingCell {
    
    func setupViews() {
        
        containerView.add(to: contentView).snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        button.add(to: containerView).snp.makeConstraints {
            $0.left.equalTo(12)
            $0.bottom.equalTo(-14)
            $0.height.equalTo(24)
            $0.width.lessThanOrEqualTo(180)
            $0.width.greaterThanOrEqualTo(83.auto)
        }
        
        imageView.add(to: containerView).snp.makeConstraints {
            $0.right.equalTo(-10)
            $0.top.bottom.equalToSuperview()
            $0.width.equalTo(imageView.snp.height)
        }
        
        titleLabel.add(to: containerView).snp.makeConstraints {
            $0.left.equalTo(12)
            $0.top.equalTo(12.auto)
            $0.right.equalTo(imageView.snp.left)
            $0.bottom.equalTo(button.snp.top).offset(-12.auto)
        }
        
    }

}

extension ProcessGuidingCell {
    
    func refresh(with model: HomeGuidingModel) {
            
//        titleLabel.text = model.title
        titleLabel.attributedText = model.attributedTitle
        imageView.setImageWith(url: model.imageUrl, placeholderImage: nil)
        button.setTitle(model.buttonTitle, for: .normal)
        button.isEnabled = model.isButtonEnabled
        button.alpha = model.isButtonEnabled ? 1 : 0.3
        
    }
    
}

private extension ProcessGuidingCell {
    
    @objc func handleClick() {
    
        print("机会 ------- ")
        
    }
    
}
