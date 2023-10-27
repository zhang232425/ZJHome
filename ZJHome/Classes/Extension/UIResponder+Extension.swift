//
//  UIResponder+Extension.swift
//  ZJHome
//
//  Created by Jercan on 2023/10/27.
//

import Foundation

/**
 UIResponder: next
 AnyHashable:
 */

extension UIResponder {
    
    @objc func handlerEvent(name: String, userInfo: [AnyHashable: Any]) {
        
        if let handler = next {
            handler.handlerEvent(name: name, userInfo: userInfo)
        }
        
    }
    
}
