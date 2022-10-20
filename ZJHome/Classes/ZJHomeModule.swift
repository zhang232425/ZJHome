//
//  ZJHomeModule.swift
//  Action
//
//  Created by Jercan on 2022/10/18.
//

import Foundation
import ZJRouter
import ZJRoutableTargets

public final class ZJHomeModule: ZJModule {
    
    public init() {}
    
    public func initialize() {
        
        ZJHomeRoutableTarget.register(path: ZJHomeRoutePath.home) { _ in
            return HomeViewController()
        }
        
    }
    
}
