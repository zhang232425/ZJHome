//
//  P2PProductType.swift
//  ZJHome
//
//  Created by Jercan on 2023/10/23.
//

import HandyJSON

enum P2PProductType: Int, HandyJSONEnum {
    
    case unknown     = -1
    case fixed       = 2000
    case installment = 3000
    case flexible    = 4000
    
}
