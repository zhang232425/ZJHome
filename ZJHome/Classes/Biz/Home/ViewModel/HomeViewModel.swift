//
//  HomeViewModel.swift
//  Action
//
//  Created by Jercan on 2022/10/18.
//

import Action
import RxCocoa
import RxSwift
import ZJRequest

/*
final class HomeViewModel {
    
    /// 首页布局
    private(set) lazy var homeLayoutAction: Action<(), HomeLayoutModel> = .init {
        return Request.homeLayout()
    }
    
}
 */


final class HomeViewModel {
    
    private var layoutAction: Action<(), HomeLayoutModel>!
    
    init() {
        setupActions()
        bindData()
    }
    
}

private extension HomeViewModel {
    
    func setupActions() {
        layoutAction = .init(workFactory: {
            Request.homeLayout().delay(.milliseconds(200), scheduler: MainScheduler.instance)
        })
    }
    
    func bindData() {
        
    }
    
}

extension HomeViewModel {
    
    func requestLayout() {
        layoutAction.execute()
    }
    
}

extension HomeViewModel {
    
    var homeLayoutModel: Observable<HomeLayoutModel> { layoutAction.elements.share(replay: 1) }
    var homeLayoutError: Observable<Error> { layoutAction.underlyingError }
    
}
