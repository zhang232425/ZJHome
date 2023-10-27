//
//  HomeFooterView.swift
//  ZJHome
//
//  Created by Jercan on 2023/10/27.
//

import UIKit

class HomeFooterView: UIView {
    
    private lazy var imageView = UIImageView().then {
        $0.image = UIImage.dd.named("home_footer_image")
    }
    
    private lazy var button = UIButton(type: .custom).then {
        $0.titleLabel?.font = .systemFont(ofSize: 10, weight: .regular)
        $0.setTitleColor(.init(hexString: "#747474"), for: .normal)
        $0.setTitleColor(UIColor(hexString: "#747474").withAlphaComponent(0.5), for: .highlighted)
        $0.addTarget(self, action: #selector(handleClick), for: .touchUpInside)
        $0.setTitle(Locale.homeFooterDisclaimer.localized, for: .normal)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) { fatalError() }
    
    private func setupUI() {
        
        imageView.add(to: self).snp.makeConstraints {
            $0.top.equalTo(16)
            $0.centerX.equalToSuperview()
        }
        
        button.add(to: self).snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(imageView.snp.bottom)
            $0.height.equalTo(30)
            $0.bottom.equalTo(-20)
        }
    }
    
    @objc private func handleClick() {
        
        HomeItemEvent(.brandLogo).post(by: self)
    }
}

