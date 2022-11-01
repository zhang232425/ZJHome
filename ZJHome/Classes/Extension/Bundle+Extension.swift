//
//  Bundle+Extension.swift
//  ZJHome
//
//  Created by Jercan on 2022/10/25.
//

import Foundation

extension Bundle {
    
    static var framework_ZJHome: Bundle {
        let frameworkName = "ZJHome"
        let resourcePath: NSString = .init(string: Bundle(for: ZJHomeClass.self).resourcePath ?? "")
        let path = resourcePath.appendingPathComponent("/\(frameworkName).bundle")
        return Bundle(path: path)!
    }
    
    private class ZJHomeClass {}
    
}
