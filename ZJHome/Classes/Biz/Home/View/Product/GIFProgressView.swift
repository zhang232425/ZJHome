//
//  GIFProgressView.swift
//  ZJHome
//
//  Created by Jercan on 2023/10/27.
//

import UIKit
import ZJCommonView

class GIFProgressView: CommonProgressView {
    
    enum ColorStyle {
        case yellow
        case orange
    }
    
    var colorStyle = ColorStyle.yellow {
        didSet {
            let asset = NSDataAsset(name: colorStyle.gifName, bundle: .framework_ZJHome)
            imageView.animatedImageData = asset?.data
        }
    }
    
    private let imageSize = CGSize(width: 21, height: 14)
    
    private lazy var imageView = GIFImageView().then {
        $0.onSetHighlighted = { [weak self] _ in
            self?.startGIFAnimating()
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    
        customProgressWidthTransformer = { [weak self] progress in
            guard let self = self else { return 0 }
            let leading = self.bounds.height / 2
            let range = self.bounds.width - leading - self.imageSize.width
            let percent = max(0, min(1, progress))
            return leading + (percent * range) + leading
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    
        let leading = bounds.height / 2
        let range = bounds.width - leading - imageSize.width
        let percent = max(0, min(1, progress))
        imageView.frame.origin.x = leading + (percent * range)
        
    }
    
}

private extension GIFProgressView {
    
    func setupViews() {
        
        imageView.add(to: self).snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.size.equalTo(imageSize)
        }
        
    }
    
}

extension GIFProgressView {
    
    func startGIFAnimating() {
        
        if !imageView.isAnimating {
            imageView.startAnimating()
        }
        
    }
    
}

private extension GIFProgressView.ColorStyle {
    
    var gifName: String {
        switch self {
        case .yellow:
            return "home_progress_gif_yellow"
        case .orange:
            return "home_progress_gif_orange"
        }
    }
    
}
