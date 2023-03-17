//
//  HomeAPI.swift
//  ZJHome
//
//  Created by Jercan on 2022/10/19.
//

import Moya
import ZJRequest

enum HomeAPI {
    
    /// 首页布局
    case homeLayout
    
    /// KTB信息
    case ktbInfo
    
}

extension HomeAPI: ZJRequestTargetType {
    
    var path: String {
        switch self {
        case .homeLayout:
            return "/homepage/getHomePageModule"
        case .ktbInfo:
            return "/tips/repayment/rate"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .homeLayout:
            return .get
        case .ktbInfo:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .homeLayout:
            return .requestPlain
        case .ktbInfo:
            return .requestPlain
        }
    }
    
    var sampleData: Data { ".".data(using: .utf8)! }
    var headers: [String : String]? { nil }
    var baseURL: URL { URL(string: "https://test-app.pintarplatformdigital.com/api/app")! }
    var timeoutInterval: TimeInterval { return 10 }
    
}
