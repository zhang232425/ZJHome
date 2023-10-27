//
//  FinanceBaseView.swift
//  ZJHome
//
//  Created by Jercan on 2023/10/27.
//

import UIKit

class FinanceBaseView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initialize() {
        
    }

}

class FinanceItemBaseView: FinanceBaseView {
    
    override func initialize() {
        layer.cornerRadius = 4
        layer.masksToBounds = true
        layer.borderWidth = 1
        layer.borderColor = UIColor(hexString: "#F0F0F0").cgColor
    }
    
}
