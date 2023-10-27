//
//  HomeAPI.swift
//  ZJHome
//
//  Created by Jercan on 2022/10/19.
//

import Moya
import ZJRequest
import ZJCommonDefines

enum HomeAPI {
    
    /// 首页布局
    case homeLayout
    
    /// KTB信息
    case ktbInfo
    
    /// 引导步骤
    case guideProgress
    
    /// 新手产品
    case noviceProducts
    
    /// 推荐产品
    case recommendProducts
    
    /// Banner
    case banner
    
    /// 首页财经快讯
    case financeBrief
    
    /// 首页理财学堂
    case financeCourse
    
    /// 待支付的投资订单数量
    case unpaidCount
    
}

extension HomeAPI: ZJRequestTargetType {
    
    var path: String {
        switch self {
        case .homeLayout:
            return "/homepage/getHomePageModule"
        case .ktbInfo:
            return "/tips/repayment/rate"
        case .guideProgress:
            return "/user/task/overviewList"
        case .noviceProducts:
            return "/biz/product/getNewUserProductList"
        case .recommendProducts:
            return "/biz/product/getHomeProductList"
        case .banner:
            return "/activity/activity/list/version/app"
        case .financeBrief:
            return "/biz/finc/brief/homepage"
        case .financeCourse:
            return "/biz/finc/home/recommend"
        case .unpaidCount:
            return "/biz/asset/trade/unpaid/countV2"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .homeLayout:
            return .get
        case .ktbInfo:
            return .get
        case .guideProgress:
            return .get
        case .noviceProducts:
            return .get
        case .recommendProducts:
            return .get
        case .banner:
            return .get
        case .financeBrief:
            return .get
        case .financeCourse:
            return .get
        case .unpaidCount:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .homeLayout:
            return .requestPlain
        case .ktbInfo:
            return .requestPlain
        case .guideProgress:
            return .requestPlain
        case .noviceProducts:
            return .requestParameters(parameters: ["source": 1], encoding: URLEncoding.default)
        case .recommendProducts:
            return .requestParameters(parameters: ["source": 1], encoding: URLEncoding.default)
        case .banner:
            return .requestPlain
        case .financeBrief:
            return .requestParameters(parameters: ["size": 2], encoding: URLEncoding.default)
        case .financeCourse:
            return .requestPlain
        case .unpaidCount:
            return .requestPlain
        }
    }
    
    var sampleData: Data { ".".data(using: .utf8)! }
    var headers: [String : String]? { nil }
    var baseURL: URL { URL(string: "\(ZJUrl.server)/api/app")! }
    var timeoutInterval: TimeInterval { return 10 }
    
}
