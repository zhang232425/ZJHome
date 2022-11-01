//
//  Namespace.swift
//  ZJHome
//
//  Created by Jercan on 2022/10/25.
//

import Foundation

protocol NamespaceWrappable {
    
    associatedtype WrapperType
    
    var dd: WrapperType { get }
    
    static var dd: WrapperType.Type { get }
    
}

extension NamespaceWrappable {
    
    var dd: NamespaceWrapper<Self> {
        return NamespaceWrapper(value: self)
    }
    
    static var dd: NamespaceWrapper<Self>.Type {
        return NamespaceWrapper.self
    }
}

struct NamespaceWrapper<T> {
    
    let warppedValue: T
    
    init(value: T) {
        warppedValue = value
    }
}
