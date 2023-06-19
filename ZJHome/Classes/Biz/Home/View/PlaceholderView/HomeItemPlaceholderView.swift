//
//  HomeItemPlaceholderView.swift
//  Action
//
//  Created by Jercan on 2023/6/14.
//

import UIKit

// var edgeInsets = UIEdgeInsets(top: 14, left: 16, bottom: 14, right: 16)

class HomeItemPlaceholderView: UIView {

    static var defaultHeight: CGFloat { 176.auto }
    
    var edgeInsets = UIEdgeInsets(top: 14, left: 16, bottom: 14, right: 16)
    
    private lazy var containerView = UIView()
    
    private lazy var layer1 = CALayer().then {
        $0.backgroundColor = UIColor(hexString: "#F4F4F4").cgColor
        $0.cornerRadius = 4
        $0.masksToBounds = true
    }
    
    private lazy var layer2 = CALayer().then {
        $0.backgroundColor = UIColor(hexString: "#F4F4F4").cgColor
        $0.cornerRadius = 4
        $0.masksToBounds = true
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        positionSubLayers()
    }
    
}

private extension HomeItemPlaceholderView {
    
    func setupViews() {
        
        containerView.add(to: self).snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.height.equalTo(Self.defaultHeight)
        }
        
        layer.addSublayer(layer1)
        layer.addSublayer(layer2)
        
    }
    
    func positionSubLayers() {
        
        let width = bounds.width
        let height = bounds.height
        
        let layer1_x = edgeInsets.left
        let layer1_y = edgeInsets.top
        let layer1_w =  width * 0.5
        let layer1_h = 14.0
        layer1.frame = .init(x: layer1_x, y: layer1_y, width: layer1_w, height: layer1_h)
        
        let layer2_x = edgeInsets.left
        let layer2_y = layer1.frame.maxY + 20
        let layer2_w = width - (edgeInsets.left + edgeInsets.right)
        let layer2_h = height - edgeInsets.bottom - layer2_y
        layer2.frame = .init(x: layer2_x, y: layer2_y, width: layer2_w, height: layer2_h)
        
    }

}


