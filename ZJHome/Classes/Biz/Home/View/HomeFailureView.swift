//
//  HomeFailureView.swift
//  ZJHome
//
//  Created by Jercan on 2023/3/6.
//

import UIKit

class HomeFailureView: UIView {
    
    // MARK: - Property
    var refreshBlock: (() -> ())?
    
    // MARK: - Lazy Load
    private lazy var imageView = UIImageView().then {
        $0.image = UIImage.dd.named("no_signal")
    }
    
    private lazy var hintLabel = UILabel().then {
        $0.textColor = UIColor(hexString: "#A8AAB4")
        $0.font = .regular14
        $0.textAlignment = .center
        $0.numberOfLines = 0
        $0.text = Locale.noSignal.localized
    }
    
    private lazy var button = UIButton(type: .custom).then {
        $0.layer.borderWidth = 1
        $0.layer.cornerRadius = 36 * 0.5
        $0.layer.masksToBounds = true
        $0.layer.borderColor = UIColor(hexString: "#FF7D0F").cgColor
        $0.titleLabel?.font = .medium14
        $0.setTitleColor(UIColor(hexString: "#FF7D0F").withAlphaComponent(0.5), for: .highlighted)
        $0.setTitleColor(UIColor(hexString: "#FF7D0F"), for: .normal)
        $0.addTarget(self, action: #selector(onClick), for: .touchUpInside)
        $0.setTitle(Locale.refresh.localized, for: .normal)
    }

    // MARK: - Init Method
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

private extension HomeFailureView {
    
    func setupViews() {
        
        imageView.add(to: self).snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview().multipliedBy(0.7)
            $0.width.height.equalTo(255)
        }
        
        hintLabel.add(to: self).snp.makeConstraints {
            $0.left.right.equalToSuperview().inset(20)
            $0.top.equalTo(imageView.snp.bottom).offset(20)
        }
        
        button.add(to: self).snp.makeConstraints {
            $0.top.equalTo(hintLabel.snp.bottom).offset(20)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(100)
            $0.height.equalTo(36)
        }
    
    }
    
    @objc func onClick() {
        refreshBlock?()
    }
    
}

