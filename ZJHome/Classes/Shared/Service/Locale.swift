//
//  Locale.swift
//  ZJHome
//
//  Created by Jercan on 2022/11/1.
//

import Foundation
import ZJLocalizable

enum Locale: String {
    
    // MARK: 通用
    case networkOffline
    case requestTimedOut
    case requestFailed
    
    case welcome
    case login
    case noSignal
    case refresh
    
    case guideHeaderName
    
}

extension Locale: ZJLocalizable {
    
    var key: String { rawValue }
    
    var table: String { "Locale" }
    
    var bundle: Bundle { .framework_ZJHome }
    
}
