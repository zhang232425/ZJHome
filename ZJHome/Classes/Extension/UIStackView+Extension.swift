//
//  UIStackView+Extension.swift
//  ZJHome
//
//  Created by Jercan on 2023/6/15.
//

import Foundation

extension UIStackView {
    
    func clearArrangedSubviews() {
        arrangedSubviews.reversed().forEach {
            self.removeArrangedSubview($0)
            $0.removeFromSuperview()
        }
    }
    
}
