//
//  QuickEntryView.swift
//  ZJHome
//
//  Created by Jercan on 2023/3/15.
//

import UIKit

class QuickEntryView: UIView {
    
    // MARK: - Property
    private let height = CGFloat(104)
    private let corner = CGFloat(16)
    
    // MARK: - Lazy Load
    private lazy var stackView = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 0
        $0.distribution = .fillEqually
        $0.alignment = .fill
    }
    
    // MARK: - Init Method
    override init(frame: CGRect) {
        super.init(frame: frame)
        config()
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

private extension QuickEntryView {
    
    func config() {
        self.backgroundColor = UIColor(hexString: "#FFF4EA")
    }
    
    func setupViews() {
        stackView.add(to: self).snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.left.right.equalToSuperview().inset(16)
            $0.height.equalTo(height)
        }
        
        for _ in 0 ..< 3 {
            let itemView = ItemView()
            itemView.imageView.backgroundColor = .init(hexString: "#FFE3CC")
            stackView.addArrangedSubview(itemView)
        }
    }
    
    func setLoadingState() {
        
        stackView.arrangedSubviews.forEach {
            stackView.removeArrangedSubview($0)
            $0.removeFromSuperview()
        }
        
        for _ in 0 ..< 3 {
            let itemView = ItemView()
            itemView.imageView.backgroundColor = .init(hexString: "#FFE3CC")
            stackView.addArrangedSubview(itemView)
        }
    }
    
    func refresh(with models: [HomeLayoutModel.QuickEntryModel]) {
        
        stackView.clearArrangedSubviews()
        
        for model in models {
            let itemView = ItemView().then {
                $0.imageView.setImageWith(url: model.iconImgUrl, placeholderImage: nil)
                $0.label.text = model.title
                $0.model = model
            }
            stackView.addArrangedSubview(itemView)
        }
        
//        stackView.separatorColor = (models.count == 2) ? UIColor(hexString: "#F7DAC0") : nil
        
    }
    
}

extension QuickEntryView: HomeRefreshableItemView {
    
    func refresh(with state: HomeItemState<[HomeLayoutModel.QuickEntryModel]>) {
        switch state {
        case .loading:
            refreshWithLoadingState()
        case .data(let list):
            refresh(with: list)
        case .empty:
            refreshWithEmptyState()
        }
    }
    
    func refreshWithLoadingState() {
        setLoadingState()
    }
    
    func refreshWithEmptyState() {
//        let userInfo = [HomePopoverUtil.Notifications.Key.view: self]
//        NotificationCenter.default.post(name: HomePopoverUtil.Notifications.quickEntry.name, object: false, userInfo: userInfo)
    }
    
    
}

fileprivate class ItemView: UIView {
    
    var model: HomeLayoutModel.QuickEntryModel?
    
    // MARK: - Lazy Load
    private(set) lazy var imageView = UIImageView().then {
        $0.contentMode = .scaleAspectFit
    }
    
    private(set) lazy var label = UILabel().then {
        $0.textColor = UIColor(hexString: "#333333")
        $0.font = UIFont.medium14
        $0.textAlignment = .center
        $0.numberOfLines = 2
    }
    
    // MARK: - Init Method
    override init(frame: CGRect) {
        super.init(frame: frame)
        config()
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

private extension ItemView {
    
    func config() {
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(itemClick)))
    }
    
    func setupViews() {
        
        imageView.add(to: self).snp.makeConstraints {
            $0.left.right.equalToSuperview()
            $0.height.equalTo(44)
            $0.centerY.equalTo(snp.bottom).multipliedBy(0.4)
        }
        
        label.add(to: self).snp.makeConstraints {
            $0.top.equalTo(imageView.snp.bottom).offset(4)
            $0.left.right.equalToSuperview()
        }
        
    }
    
    @objc func itemClick() {
        print("点击了item ------------")
    }
    
}
