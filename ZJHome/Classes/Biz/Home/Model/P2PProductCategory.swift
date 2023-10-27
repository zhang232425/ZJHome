//
//  P2PProductCategory.swift
//  ZJHome
//
//  Created by Jercan on 2023/10/23.
//

import HandyJSON

enum P2PProductCategory: Int, HandyJSONEnum {
    
    // 全部
    case all = 0
 
    // 会员
    case member = 2
    
    // 新手
    case novice = 1
    
    // 普通
    case normal = 3
    
    // 向后兼容
    case noname_4 = 4
    case noname_5 = 5
    case noname_6 = 6
    case noname_7 = 7
    case noname_8 = 8
    case noname_9 = 9
    
}

struct ProductCategoryModel: HandyJSON {
    
    var categoryType: P2PProductCategory?
    
    var name = ""
    
    mutating func mapping(mapper: HelpingMapper) {
        mapper <<< name <-- "categoryName"
    }
    
}


