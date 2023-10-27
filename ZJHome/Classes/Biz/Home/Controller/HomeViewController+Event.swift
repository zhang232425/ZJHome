//
//  HomeViewController+Event.swift
//  ZJHome
//
//  Created by Jercan on 2023/10/27.
//

import Foundation

extension HomeViewController {
    
    @objc override func handlerEvent(name: String, userInfo: [AnyHashable : Any]) {
        
        let obj = userInfo.values.first
        
        print("点击了------")
        
        
    }
    
}
