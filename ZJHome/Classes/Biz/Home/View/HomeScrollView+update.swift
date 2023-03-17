//
//  HomeScrollView+update.swift
//  ZJHome
//
//  Created by Jercan on 2023/3/15.
//

import Foundation

extension HomeScrollView {
    
    
    
}

extension HomeItemType {
    
    var viewClass: UIView.Type {
        switch self {
        case .quickEntry:
            return QuickEntryView.self
        case .guideProgress:
            return QuickEntryView.self
        case .noviceProducts:
            return QuickEntryView.self
        case .recommendProducts:
            return QuickEntryView.self
        case .banner:
            return QuickEntryView.self
        case .finance:
            return QuickEntryView.self
        case .infoDisclosure:
            return QuickEntryView.self
        case .brandLogo:
            return QuickEntryView.self
        }
    }
    
}

extension HomeLayoutModel.SectionModel.SectionType {
    
    var homeItemType: HomeItemType? {
        switch self {
        case .unknown:
            return nil
        case .quickEntry:
            return .quickEntry
        case .guide:
            return .guideProgress
        case .novice:
            return .noviceProducts
        case .recommend:
            return .recommendProducts
        case .banner:
            return .banner
        case .finance:
            return .finance
        case .disclosure:
            return .infoDisclosure
        }
    }
    
}



