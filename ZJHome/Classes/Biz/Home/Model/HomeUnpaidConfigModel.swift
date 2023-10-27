//
//  HomeUnpaidConfigModel.swift
//  ZJHome
//
//  Created by Jercan on 2023/10/27.
//

import HandyJSON

struct HomeUnpaidConfigModel: HandyJSON {
    
    /// 待支付数量
    var unpaidCount = 0
    
    /// 显示时长，毫秒
    var displayDuration = 0
    
    mutating func mapping(mapper: HelpingMapper) {
        mapper <<< unpaidCount <-- "count"
        mapper <<< displayDuration <-- "alive"
    }
    
}
