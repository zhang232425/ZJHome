//
//  CommonProgressView.swift
//  ZJHome
//
//  Created by Jercan on 2023/10/27.
//

import UIKit

class CommonProgressView: UIView {
        
    var customProgressWidthTransformer: ((CGFloat) -> (CGFloat))?
    
    /// 当前进度
    var progress = CGFloat(0) {
        didSet {
            updateWidth()
        }
    }
    
    /// 背景颜色
    var normalColor = UIColor(hexString: "#F2F2F2") {
        didSet { backgroundColor = normalColor }
    }
    
    /// 进度颜色
    var progressColor = UIColor(hexString: "#FF7D0F") {
        didSet { progressView.backgroundColor = progressColor }
    }
    
    private lazy var progressView = UIView().then {
        $0.backgroundColor = progressColor
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
        
        layer.cornerRadius = bounds.height / 2
        progressView.layer.cornerRadius = progressView.bounds.height / 2
        progressView.layer.masksToBounds = true
        
        updateWidth()
        
    }
    
}

private extension CommonProgressView {
    
    func setupViews() {
        
        backgroundColor = normalColor
        
        progressView.add(to: self).snp.makeConstraints {
            $0.left.top.bottom.equalToSuperview()
        }
        
    }
    
    func updateWidth() {
        
        if let transform = customProgressWidthTransformer {
            progressView.frame.size.width = transform(progress)
        } else {
            let percent = max(0, min(1, progress))
            progressView.frame.size.width = percent * bounds.width
        }
        
    }
    
}
