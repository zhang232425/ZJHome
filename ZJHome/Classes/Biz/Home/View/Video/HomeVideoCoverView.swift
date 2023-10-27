//
//  HomeVideoCoverView.swift
//  ZJHome
//
//  Created by Jercan on 2023/10/27.
//

import UIKit

class HomeVideoCoverView: UIView {
    
    private lazy var playIcon = UIImageView().then {
        $0.image = UIImage.dd.named("icon_play")
    }
    
    private lazy var imageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) { fatalError() }
    
    private func setupUI() {
        
        imageView.add(to: self).snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        playIcon.add(to: self).snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
}

extension HomeVideoCoverView {
    
    func setCoverImageUrl(url: String?) {
        
        let placeholder = UIImage.dd.named("home_news_placeholder")
        imageView.setImageWith(url: url, placeholderImage: placeholder)
    }
}
