//
//  HomeNavigationBarView.swift
//  ZJHome
//
//  Created by Jercan on 2022/10/24.
//

import UIKit

class HomeNavigationBarView: BaseView {
    
    // MARK: - Lazy Load
    private lazy var containerView = UIView()
    
    private lazy var logoImageView = UIImageView().then {
        $0.image = UIImage.dd.named("home_logo")
    }
    
    private lazy var supervisionImageView = UIImageView().then {
        $0.image = UIImage.dd.named("home_ojk")
    }
    
    private lazy var label = UILabel().then {
        $0.textColor = UIColor(hexString: "#242426")
        $0.font = .bold10
        $0.textAlignment = .right
    }

    // MARK: - Init Method
    override func initialize() {
        setupViews()
        setText()
    }
    
}

private extension HomeNavigationBarView {
    
    func setupViews() {
        
        containerView.add(to: self).snp.makeConstraints {
            $0.top.equalToSuperview().inset(UIScreen.safeAreaTop)
            $0.left.right.equalToSuperview().inset(12.auto)
            $0.height.equalTo(UIScreen.navBarHeight)
            $0.bottom.equalToSuperview()
        }
        
        logoImageView.add(to: containerView).snp.makeConstraints {
            $0.left.equalToSuperview()
            $0.centerY.equalToSuperview()
            $0.size.equalTo(CGSize(width: 66.auto, height: 20.auto))
        }
        
        label.add(to: containerView).snp.makeConstraints {
            $0.right.equalToSuperview()
            $0.height.equalTo(24.auto)
            $0.centerY.equalToSuperview().offset(-0.7)
        }
        
        supervisionImageView.add(to: containerView).snp.makeConstraints {
            $0.right.equalTo(label.snp.left).offset(-2)
            $0.centerY.equalToSuperview()
            $0.size.equalTo(CGSize(width: 172.auto, height: 24.auto))
        }
        
    }
    
    func setText() {
        
        TKBInfoCache.getTKBText { [weak self] in
            self?.label.text = $0
        }
        
    }
    
}


