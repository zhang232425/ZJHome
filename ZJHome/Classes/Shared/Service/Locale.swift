//
//  Locale.swift
//  ZJHome
//
//  Created by Jercan on 2022/11/1.
//

import Foundation
import ZJLocalizable

enum Locale: String {
    case welcome
    case login
}

extension Locale: ZJLocalizable {
    
    var key: String { rawValue }
    
    var table: String { "Locale" }
    
    var bundle: Bundle { .framework_ZJHome }
    
}
