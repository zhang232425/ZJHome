//
//  HotNewsView.swift
//  ZJHome
//
//  Created by Jercan on 2023/10/27.
//

import UIKit

class HotNewsView: FinanceItemBaseView {
    
    private var newsId: String?
    private var newsType: String?
    
    private lazy var label = UILabel().then {
        $0.textColor = .init(hexString: "#333333")
        $0.font = .systemFont(ofSize: 14, weight: .medium)
        $0.numberOfLines = 3
    }

    override func initialize() {
        super.initialize()
        
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleClick)))
        
        label.add(to: self).snp.makeConstraints {
            $0.edges.equalToSuperview().inset(12)
        }
    }
    
    func setNewsTitle(_ title: String?, id: String, type: String) {
        
        newsId = id
        newsType = type
        setText(title)
    }
    
    private func setText(_ text: String?) {
        
        let attrStr = NSMutableAttributedString()
        let attachment = FinanceHotNewsTagView.imageAttachment(Locale.financeHotNews.localized)
        attrStr.append(attachment)
        
        let text = "  " + (text ?? "")
        let attr1 = NSAttributedString(string: text, attributes: [.foregroundColor: UIColor(hexString: "#333333"),
                                                                  .font: UIFont.systemFont(ofSize: 14, weight: .medium)])
        attrStr.append(attr1)
        
        label.attributedText = attrStr
    }
    
    @objc private func handleClick() {
        
        if let id = newsId, let type = newsType {
            HomeExtraEvent.clickFinanceDetail(id: id, type: type).post(by: self)
//            ReportEvent.financeNews.report()
        }
    }
}
