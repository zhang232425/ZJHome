//
//  UIScrollView+Extension.swift
//  ZJHome
//
//  Created by Jercan on 2023/8/30.
//

import RxSwift
import RxCocoa
import ZJRefresh

extension Reactive where Base: UIScrollView {
    
    var addPullToRefresh: Observable<()> {
        
        return .create { [weak base] (observer) -> Disposable in
            
            if let base = base {
                base.addPullToRefresh {
                    observer.onNext(())
                }
            } else {
                observer.onCompleted()
            }
            
            return Disposables.create {
                base?.endPullToRefresh()
            }
            
        }
        
    }
    
    var addInfinityScroll: Observable<()> {
        
        return .create { [weak base] observer -> Disposable in
            
            if let base = base {
                base.addInfinityScroll {
                    observer.onNext(())
                }
            } else {
                observer.onCompleted()
            }
            
            return Disposables.create {
                base?.endInfinityScroll()
            }
            
        }
        
    }
    
    var endPullToRefresh: Binder<()> {
        return Binder(base) { control, _ in
            control.endPullToRefresh()
            control.resetNoMoreData()
        }
    }
    
    var endIndinityScroll: Binder<Bool> {
        return Binder(base) { (controll, hasMore) in
            if hasMore {
                controll.endInfinityScroll()
            } else {
                controll.noticeNoMoreData()
            }
        }
    }
    
}

extension UIScrollView {
    
    func scrollTo(page: Int, animated: Bool = true) {
        let offset = CGPoint(x: bounds.width * CGFloat(page), y: 0)
        setContentOffset(offset, animated: animated)
    }
    
}

extension UIScrollView {
    
    enum PageBehaviorOnEndDecelerating {
        /// page没变
        case staySame
        /// page增加了
        case increased
        /// page减少了
        case decreased
    }
    
    
}
