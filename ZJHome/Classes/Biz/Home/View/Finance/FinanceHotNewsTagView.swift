//
//  FinanceHotNewsTagView.swift
//  ZJHome
//
//  Created by Jercan on 2023/10/27.
//

import UIKit

class FinanceHotNewsTagView: UIView {
    
    private let iconSize = CGSize(width: 12, height: 12)
    
    private lazy var fireIcon = UIImageView().then {
        $0.image = UIImage.dd.named("icon_hot")
    }
    
    private lazy var label = UILabel().then {
        $0.textColor = .init(hexString: "#FF7D0F")
        $0.font = .systemFont(ofSize: 12, weight: .regular)
        $0.numberOfLines = 1
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .init(hexString: "#FFF4EA")
        layer.cornerRadius = 4
        fireIcon.add(to: self)
        label.add(to: self)
    }
    
    required init?(coder: NSCoder) { fatalError() }
    
    private func makeImage(with text: String) -> UIImage? {
        
        label.text = text
        label.sizeToFit()
        
        fireIcon.frame = .init(origin: .init(x: 3, y: 3), size: iconSize)
        label.frame.origin = .init(x: iconSize.width + 5, y: 2)
        frame = .init(x: 0, y: 0, width: label.bounds.width + iconSize.width + 11, height: label.bounds.height + 4)
        
        UIGraphicsBeginImageContextWithOptions(bounds.size, false, UIScreen.main.scale)
        
        if let ctx = UIGraphicsGetCurrentContext() {
            layer.render(in: ctx)
            let img = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            return img
        }
        return nil
    }
    
    static func imageAttachment(_ tag: String) -> NSAttributedString {
        
        let attachment = NSTextAttachment()
        attachment.image = Self().makeImage(with: tag)
        let tagAttr = NSMutableAttributedString(attachment: attachment)
        tagAttr.addAttribute(.baselineOffset, value: -3, range: NSMakeRange(0, 1))
        return tagAttr
    }
}
