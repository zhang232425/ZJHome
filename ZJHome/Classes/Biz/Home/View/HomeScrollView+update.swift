//
//  HomeScrollView+update.swift
//  ZJHome
//
//  Created by Jercan on 2023/3/15.
//

import Foundation

extension HomeScrollView {
    
    func update(type: HomeItemType, model: HomeModelProtocol) {
        
        switch type {
            
        case .quickEntry:
            if let v: QuickEntryView = findSubview() {
                if let m = model as? HomeItemState<[HomeLayoutModel.QuickEntryModel]> {
                    v.refresh(with: m)
                } else if case AnyHomeItemState.empty = model {
                    v.refreshWithEmptyState()
                }
            }
            
        case .guideProgress:
            if let v: ProcessGuidingView = findSubview() {
                if let m = model as? HomeItemState<[HomeGuidingModel]> {
                    v.refresh(with: m)
                } else if case AnyHomeItemState.empty = model {
                    v.refreshWithEmptyState()
                }
            }
            
        case .noviceProducts:
            break
            
        case .recommendProducts:
            break
            
        case .banner:
            if let v: HomeBannerView = findSubview() {
                if let m = model as? HomeItemState<[HomeBannerModel]> {
                    v.refresh(with: m)
                } else if case AnyHomeItemState.empty = model {
                    v.refreshWithEmptyState()
                }
            }

        case .finance:
            break
            
        case .infoDisclosure, .brandLogo:
            break
            
        }
        
    }
    
}

private extension HomeScrollView {
    
    func findSubview<V: UIView>() -> V? {
        return stackView.arrangedSubviews.filter { $0 is V }.first as? V
    }
    
}

extension HomeItemType {
    
    var viewClass: UIView.Type {
        switch self {
        case .quickEntry:
            return QuickEntryView.self
        case .guideProgress:
            return ProcessGuidingView.self
        case .noviceProducts:
            return QuickEntryView.self
        case .recommendProducts:
            return QuickEntryView.self
        case .banner:
            return HomeBannerView.self
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



