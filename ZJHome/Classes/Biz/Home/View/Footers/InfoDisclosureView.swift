//
//  InfoDisclosureView.swift
//  ZJHome
//
//  Created by Jercan on 2023/10/27.
//

import UIKit

/// 信息披露区View
class InfoDisclosureView: UIView {
    
    private let defaultHeight = 142.auto
    
    private lazy var stackView = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 8
        $0.distribution = .fillEqually
        $0.alignment = .fill
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) { fatalError() }
    
    private func setupUI() {
        
        stackView.add(to: self).snp.makeConstraints {
            $0.top.equalTo(6)
            $0.left.right.equalToSuperview().inset(16.auto)
            $0.height.equalTo(defaultHeight)
            $0.bottom.equalToSuperview()
        }
        
        ItemType.allCases.forEach {
            let itemView = ItemView()
            itemView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleClickItem)))
            itemView.imageView.image = UIImage.dd.named($0.imageName)
            itemView.label.text = $0.title
            stackView.addArrangedSubview(itemView)
        }
    }
    
    @objc private func handleClickItem() {
        
        HomeItemEvent(.infoDisclosure).post(by: self)
    }
}

fileprivate class ItemView: UIView {
    
    private(set) lazy var imageView = UIImageView()
    
    private(set) lazy var label = UILabel().then {
        $0.textColor = .init(hexString: "#666666")
        $0.font = .systemFont(ofSize: 12, weight: .regular)
        $0.textAlignment = .center
        $0.numberOfLines = 2
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) { fatalError() }
    
    private func setupUI() {
        
        imageView.add(to: self).snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(snp.bottom).multipliedBy(0.634)
            $0.width.equalToSuperview().multipliedBy(0.558)
            $0.height.equalTo(imageView.snp.width)
        }
        
        label.add(to: self).snp.makeConstraints {
            $0.top.equalTo(imageView.snp.bottom).offset(8.auto)
            $0.left.right.equalToSuperview()
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        imageView.layer.cornerRadius = imageView.bounds.height / 2
        imageView.layer.masksToBounds = true
    }
}

fileprivate enum ItemType: CaseIterable {
    case item_1
    case item_2
    case item_3
    
    var imageName: String {
        switch self {
        case .item_1: return "home_disclaimer_icon1"
        case .item_2: return "home_disclaimer_icon2"
        case .item_3: return "home_disclaimer_icon3"
        }
    }
    
    var title: String {
        switch self {
        case .item_1: return Locale.homeInfoDisclosureText1.localized
        case .item_2: return Locale.homeInfoDisclosureText2.localized
        case .item_3: return Locale.homeInfoDisclosureText3.localized
        }
    }
}
