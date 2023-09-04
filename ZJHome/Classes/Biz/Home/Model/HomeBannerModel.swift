//
//  HomeBannerModel.swift
//  ZJHome
//
//  Created by Jercan on 2023/8/30.
//

import HandyJSON

struct HomeBannerModel: HandyJSON {
    
    enum RouteType: Int, HandyJSONEnum {
        case normal        = 0  // unknown、normal
        case commonWeb     = 1
        case productDetail = 2
        case productList   = 3
        case insureWeb     = 99 // 赠险web
    }
    
    enum ProductType: Int, HandyJSONEnum {
        case normal      = -999
        case p2p_all     = 0
        case p2p_novice  = 1
        case p2p_member  = 2
        case p2p_normal  = 3
        case insurance   = 60
        /// 定期
        case fixed       = 2000
        /// 消费分期
        case consumption = 3000
        /// 活期
        case flexible    = 4000
    }
    
    
    var id = ""
    
    var order = 0
    
    var route = RouteType.normal
    
    var imageUrl = ""
    
    var webUrl = ""
    
    var productId = ""
    
    var productType = ProductType.normal
    
    var insureWeb_productCode = ""
    
    /*** 知识点：
     URLComponents：该类苹果在 iOS 7中添加,它(NSURLComponents)可以方便的把 URL 地址分解成多个部分
     schema://host[:port#]/path/.../[?query-string][#anchor]
     schema:指定低层使用的协议,例如 http https ftp 等.
     host:HTTP 服务器的 IP 地址或者域名
     path:访问资源的路径
     query-string: 发送给 http 服务器的数据
     anchor: 锚
     
     lowercased()：字符串转小写
     uppercased()：字符串转大写
     */
    
    mutating func didFinishMapping() {
        if let url = URL(string: webUrl),
           let components = URLComponents(url: url, resolvingAgainstBaseURL: true),
           components.path.lowercased().contains("insurance"),
           let code = components.queryItems?.filter({ $0.name == "productCode" }).first?.value {
            route = .insureWeb
            insureWeb_productCode = code
        }
    }

    mutating func mapping(mapper: HelpingMapper) {
        mapper <<< order <-- "sequence"
        mapper <<< imageUrl <-- "bannerUrl"
        mapper <<< webUrl <-- "url"
        mapper <<< route <-- "type"
        mapper <<< productId <-- "productTemplateId"
    }
    
}
