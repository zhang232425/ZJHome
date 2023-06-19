//
//  HomeItem.swift
//  ZJHome
//
//  Created by Jercan on 2023/3/15.
//

import Foundation

protocol HomeModelProtocol {}

enum HomeItemState<T>: HomeModelProtocol {
    
    case loading
    
    case data(T)
    
    case empty
    
    init(data: T) {
        self = .data(data)
    }
    
}

typealias AnyHomeItemState = HomeItemState<Any>

enum HomeItemType {
    
    /// 快捷入口
    case quickEntry
    
    /// 引导步骤
    case guideProgress
    
    /// 新手产品
    case noviceProducts
    
    /// 推荐产品
    case recommendProducts
    
    /// Banner
    case banner
    
    /// 财经信息
    case finance
    
    /// 信息披露
    case infoDisclosure
    
    /// 品牌标识
    case brandLogo
    
}
