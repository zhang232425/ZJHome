//
//  UIImage+Extension.swift
//  ZJHome
//
//  Created by Jercan on 2022/10/25.
//

import UIKit
import ZJExtension

extension UIImage: NamespaceWrappable {}

extension NamespaceWrapper where T: UIImage {
    
    static func named(_ name: String) -> UIImage? {
        return UIImage(name: name, bundle: .framework_ZJHome)
    }
    
}
