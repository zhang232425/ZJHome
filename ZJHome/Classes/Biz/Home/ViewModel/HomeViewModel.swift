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

final class HomeViewModel {
    
    /// 首页布局
    private(set) lazy var homeLayoutAction: Action<(), Bool> = .init {
        return Request.homeLayout()
    }
    
}
