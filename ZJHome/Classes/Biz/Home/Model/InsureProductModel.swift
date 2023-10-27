//
//  InsureProductModel.swift
//  ZJHome
//
//  Created by Jercan on 2023/10/20.
//

import HandyJSON

struct InsureProductModel: HandyJSON {
    
    // 唯一标识
    var identifier = ""
    
    var name = ""
    
    var imageUrl = ""
    
    var total = 0
    
    var remainCount = 0
    
    // 剩余数量描述
    var remainDesc = ""
    
    // 保额描述
    var amountDesc = ""
    
    // 标签文字
    var label = ""
    
    // 商业险详细描述
    var detailDescription = ""
    
    // 商业险价格描述
    var priceDescription = ""
    
    mutating func mapping(mapper: HelpingMapper) {
        mapper <<< identifier <-- "productCode"
        mapper <<< name <-- "productName"
        mapper <<< imageUrl <-- "listImageUrl"
        mapper <<< remainCount <-- "surplus"
        mapper <<< remainDesc <-- "surplusText"
        mapper <<< amountDesc <-- "insureAmountText"
        mapper <<< detailDescription <-- "tagline"
        mapper <<< priceDescription <-- "priceInfo"
    }
    
}

extension InsureProductModel {
    
    var progress: CGFloat {
        1 - (CGFloat(remainCount) / CGFloat(max(1, total)))
    }
    
}

