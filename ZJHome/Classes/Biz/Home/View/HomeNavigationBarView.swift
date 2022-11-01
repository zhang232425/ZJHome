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
    
    private lazy var bgImageView = UIImageView().then {
        $0.image = UIImage.dd.named("home_top_one")
    }
    
    private lazy var titleLabel = UILabel().then {
        $0.textColor = UIColor(hexString: "#000000")
        $0.font = .bold20
        $0.text = Locale.welcome.localized
        //$0.text = "Welcome to OneAset"
    }

    // MARK: - Init Method
    override func initialize() {
        setupViews()
    }
    
}

private extension HomeNavigationBarView {
    
    func setupViews() {
        
        print("welcome ===== \(Locale.welcome.localized)")
        
        bgImageView.add(to: self).snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        containerView.add(to: self).snp.makeConstraints {
            $0.top.equalToSuperview().inset(UIScreen.safeAreaBottom)
            $0.left.bottom.right.equalToSuperview()
            $0.height.equalTo(UIScreen.navBarHeight)
        }
        
        titleLabel.add(to: containerView).snp.makeConstraints {
            $0.left.equalToSuperview().inset(20)
            $0.centerY.equalToSuperview()
        }
        
    }
    
}
