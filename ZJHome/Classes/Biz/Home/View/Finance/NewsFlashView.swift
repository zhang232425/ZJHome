//
//  NewsFlashView.swift
//  ZJHome
//
//  Created by Jercan on 2023/10/27.
//

import UIKit

class NewsFlashView: FinanceItemBaseView {
    
    private lazy var backgroundView = UIImageView(image: UIImage.dd.named("news_flash_bg"))
    
    private lazy var flashIcon = UIImageView().then {
        $0.image = UIImage.dd.named("news_flash_id")
    }
    
    private lazy var flashIconRight = UIImageView(image: UIImage.dd.named("icon_flash_right"))
    
    private lazy var contentView = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 9
        $0.distribution = .fillEqually
        $0.alignment = .fill
    }

    override func initialize() {
        super.initialize()
        
        backgroundView.add(to: self).snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.height.equalTo(backgroundView.snp.width).multipliedBy(0.3)
        }
        
        flashIcon.add(to: backgroundView).snp.makeConstraints {
            $0.top.equalToSuperview().inset(16.auto)
            $0.left.equalTo(13)
        }
        
        flashIconRight.add(to: backgroundView).snp.makeConstraints {
            $0.left.equalTo(flashIcon.snp.right).offset(8)
            $0.centerY.equalTo(flashIcon)
        }
        
        contentView.add(to: backgroundView).snp.makeConstraints {
            $0.top.equalTo(42.auto)
            $0.left.equalTo(15)
            $0.right.equalTo(-13)
            $0.bottom.equalTo(-16.auto)
        }
        
    }

}

extension NewsFlashView {
    
    func refreshWith(htmls: [String]) {
        
        contentView.arrangedSubviews.forEach {
            contentView.removeArrangedSubview($0)
            $0.removeFromSuperview()
        }
        
        htmls.forEach {
            let itemView = FlashItemView()
            itemView.setHTML(text: $0)
            
            contentView.addArrangedSubview(itemView)
            itemView.snp.makeConstraints {
                $0.left.right.equalToSuperview()
            }
        }
    }
}

private class FlashItemView: FinanceBaseView {
    
    private lazy var indicatorView = UIView().then {
        $0.layer.cornerRadius = 1.5
        $0.backgroundColor = .init(hexString: "#FF7D0F")
    }
    
    private lazy var label = UILabel().then {
        $0.textColor = .init(hexString: "#333333")
        $0.font = .systemFont(ofSize: 12, weight: .regular)
    }
    
    override func initialize() {
        
        backgroundColor = .clear
        
        indicatorView.add(to: self).snp.makeConstraints {
            $0.left.equalToSuperview()
            $0.centerY.equalToSuperview()
            $0.width.height.equalTo(3)
        }
        
        label.add(to: self).snp.makeConstraints {
            $0.left.equalTo(indicatorView.snp.right).offset(5)
            $0.height.greaterThanOrEqualTo(14).priority(.high)
            $0.right.top.bottom.equalToSuperview()
        }
        
    }
    
    func setHTML(text: String?) {
        
        let string = formattedHTML(text ?? "")
        let data = string.data(using: .unicode) ?? Data()
        typealias OptionKey = NSAttributedString.DocumentReadingOptionKey
        let options: [OptionKey: Any] = [.documentType: NSAttributedString.DocumentType.html,
                                         .characterEncoding: String.Encoding.unicode.rawValue]
        let attrStr = try? NSAttributedString(data: data, options: options, documentAttributes: nil)
        label.attributedText = attrStr ?? .init(string: string)
        label.lineBreakMode = .byTruncatingTail
    }
    
    private func formattedHTML(_ origin: String) -> String {
        
        let processed: String
        
        if let regex = try? NSRegularExpression(pattern: #"font-family[\s\S]*;"#, options: []) {
            let range = NSMakeRange(0, origin.count)
            processed = regex.stringByReplacingMatches(in: origin, options: [], range: range, withTemplate: "")
        } else {
            processed = origin
        }
        
        return #"""
        <span style="
        font-family: PingFangSC-Regular, sans-serif;
        font-size: \#(UIFont.systemFont(ofSize: 12, weight: .regular).pointSize);
        color: #333333;
        word-wrap: break-word;
        word-break: normal">
        \#(processed)
        </span>
        """#
    }
}
