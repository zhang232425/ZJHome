//
//  ProductCellTopTagView.swift
//  ZJHome
//
//  Created by Jercan on 2023/10/26.
//

import UIKit

class ProductCellTopTagView: UIView {
    
    private lazy var label = UILabel().then {
        $0.textColor = .white
        $0.font = UIFont.medium10
        $0.textAlignment = .center
        $0.numberOfLines = 1
    }
    
    private lazy var bgImageView = UIImageView().then {
        let image = UIImage.dd.named("product_tag_bg")
        $0.image = image?.resizableImage(withCapInsets: .init(top: 0, left: 6, bottom: -2, right: 10))
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

private extension ProductCellTopTagView {
    
    func setupViews() {
        
        bgImageView.add(to: self).snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        label.add(to: self).snp.makeConstraints {
            $0.top.equalToSuperview().inset(3.auto)
            $0.left.equalToSuperview().inset(6.auto)
            $0.right.equalToSuperview().inset(10.auto)
            $0.bottom.equalToSuperview().inset(7.auto)
        }
        
    }
    
}

extension ProductCellTopTagView {
    
    func setText(_ text: String?) {
        
        if let string = text, !string.isEmpty {
            label.text = string
            isHidden = false
        } else {
            label.text = nil
            isHidden = true
        }
        
    }
    
}
