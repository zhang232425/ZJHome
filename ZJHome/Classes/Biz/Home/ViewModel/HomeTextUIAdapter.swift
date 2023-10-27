//
//  HomeTextUIAdapter.swift
//  ZJHome
//
//  Created by Jercan on 2023/10/27.
//

import Foundation

struct HomeTextUIAdapter {
    
    private static let rateColor = UIColor(hexString: "#FF7D0F")
    
    /// 利率文字
    static func rateAttributedString(rate: Double) -> NSAttributedString {
        
        let result = NSMutableAttributedString()
        
        let numberDesc = String(format: "%.1f", rate)
        let number = NSAttributedString(string: numberDesc, attributes: [.font : UIFont.systemFont(ofSize: 34, weight: .bold),
                                                                         .foregroundColor: rateColor])
        result.append(number)
        
        let percent = NSAttributedString(string: "%", attributes: [.font : UIFont.systemFont(ofSize: 24, weight: .bold),
                                                                   .foregroundColor: rateColor])
        result.append(percent)
        
        return result
    }
    
    /// 利率文字 + 加息文字
    static func raiseRateAttributedString(rate: Double, raiseRate: Double) -> NSAttributedString {
        
        let result = NSMutableAttributedString()
        
        let numberDesc = String(format: "%.1f", rate)
        let number = NSAttributedString(string: numberDesc, attributes: [.font : UIFont.systemFont(ofSize: 34, weight: .bold),
                                                                         .foregroundColor: rateColor])
        result.append(number)
        
        let numberPercent = NSAttributedString(string: "%", attributes: [.font : UIFont.systemFont(ofSize: 24, weight: .bold),
                                                                   .foregroundColor: rateColor])
        result.append(numberPercent)
        
        let raiseRateDesc = String(format: "+%.1f", raiseRate)
        let raiseRateDescStr = NSAttributedString(string: raiseRateDesc, attributes: [.font : UIFont.systemFont(ofSize: 24, weight: .bold),
                                                                   .foregroundColor: rateColor])
        result.append(raiseRateDescStr)
        
        let raiseRatePercent = NSAttributedString(string: "%", attributes: [.font : UIFont.systemFont(ofSize: 24, weight: .bold),
                                                                   .foregroundColor: rateColor])
        result.append(raiseRatePercent)
        
        return result

    }

    static func noviceViewTitle(tag: String, text: String) -> NSAttributedString {
        
        let result = NSMutableAttributedString()
        
        let content: String
        if tag.isEmpty {
            content = text
        } else {
            result.append(TagAttachmentView.imageAttachment(tag))
            content = " " + text
        }
        
        let normal = NSAttributedString(string: content, attributes: [.font : UIFont.systemFont(ofSize: 14, weight: .medium),
                                                                      .foregroundColor: UIColor(hexString: "#333333")])
        result.append(normal)
        return result
        
    }
    
}

fileprivate class TagAttachmentView: UIView {
    
    private lazy var label = UILabel().then {
        $0.textColor = .init(hexString: "#333333")
        $0.font = .systemFont(ofSize: 10, weight: .medium)
        $0.textAlignment = .center
        $0.numberOfLines = 1
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .init(hexString: "#FFD23E")
        layer.cornerRadius = 2
        label.add(to: self)
    }
    
    required init?(coder: NSCoder) { fatalError() }
    
    private func makeImage(with text: String) -> UIImage? {
        
        label.text = text
        label.sizeToFit()
        frame = .init(x: 0, y: 0, width: label.bounds.width + 8, height: label.bounds.height + 2)
        label.center = center
        
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
        attachment.image = TagAttachmentView().makeImage(with: tag)
        let tagAttr = NSMutableAttributedString(attachment: attachment)
        tagAttr.addAttribute(.baselineOffset, value: -1.8, range: NSMakeRange(0, 1))
        return tagAttr
    }
}
