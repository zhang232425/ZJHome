//
//  HomeItemEvent.swift
//  ZJHome
//
//  Created by Jercan on 2023/10/27.
//

import Foundation

struct HomeItemEvent<T> {
    
    let type: HomeItemType
    
    let data: T
    
}

extension HomeItemEvent {
    
    func post(by responder: UIResponder) {
        
        responder.handlerEvent(name: "\(type)", userInfo: ["data": data])
        
    }
    
}

typealias AnyHomeItemEvent = HomeItemEvent<Optional<Any>>

extension AnyHomeItemEvent {
    
    init(_ type: HomeItemType) {
        self.type = type
        self.data = nil
    }
    
}

enum HomeExtraEvent {
    /// 推荐p2p产品（更多）
    case moreProduct
    /// 去财经tab
    case goFinanceTab
    /// 点击财经新闻item
    case clickFinanceDetail(id: String, type: String)
    /// 点击财经视频item
    case clickFinanceVideo(id: String, type: String)
}

extension HomeExtraEvent {
    
    var eventName: String {
        switch self {
        case .moreProduct, .goFinanceTab:
            return "\(Self.self).\(self)"
        case .clickFinanceDetail:
            return "\(Self.self).clickFinanceDetail"
        case .clickFinanceVideo:
            return "\(Self.self).clickFinanceVideo"
        }
    }
     
    func post(by responder: UIResponder) {
        
        switch self {
        case .moreProduct:
            responder.handlerEvent(name: eventName, userInfo: [:])
        case .goFinanceTab:
            responder.handlerEvent(name: eventName, userInfo: [:])
        case .clickFinanceDetail(let id, let type):
            responder.handlerEvent(name: eventName, userInfo: ["data": (id, type)])
        case .clickFinanceVideo(let id, let type):
            responder.handlerEvent(name: eventName, userInfo: ["data": (id, type)])
        }
        
    }
    
}
