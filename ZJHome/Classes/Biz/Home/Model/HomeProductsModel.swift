//
//  HomeProductsModel.swift
//  ZJHome
//
//  Created by Jercan on 2023/10/20.
//

import HandyJSON

struct HomeProductsModel: HandyJSON {
    
    // p2p产品
    var p2pProducts = [P2PProductModel]()
    
    // 保险产品
    var insureProducts = [InsureProductModel]()
    
    // 保险产品标签
    var insureTagText = ""
    
    // p2p产品标签
    var p2pTagText = ""
    
    mutating func mapping(mapper: HelpingMapper) {
        mapper <<< p2pProducts <-- "p2pProductList"
        mapper <<< insureProducts <-- "insureProductList"
        mapper <<< insureTagText <-- "insureLabel"
        mapper <<< p2pTagText <-- "p2pLabel"
    }
    
}


