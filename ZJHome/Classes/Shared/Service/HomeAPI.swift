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
    
    /// Banner
    case banner
    
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
        case .banner:
            return "/activity/activity/list/version/app"
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
        case .banner:
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
        case .banner:
            return .requestPlain
        }
    }
    
    var sampleData: Data { ".".data(using: .utf8)! }
    var headers: [String : String]? { nil }
    var baseURL: URL { URL(string: "\(ZJUrl.server)/api/app")! }
    var timeoutInterval: TimeInterval { return 10 }
    
}
