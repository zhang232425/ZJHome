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
    
}

extension HomeAPI: ZJRequestTargetType {
    
    var path: String {
        switch self {
        case .homeLayout:
            return "/homepage/getHomePageModule"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .homeLayout:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .homeLayout:
            return .requestPlain
        }
    }
    
    var sampleData: Data { ".".data(using: .utf8)! }
    var headers: [String : String]? { nil }
    var baseURL: URL { URL(string: "https://test-app.pintarplatformdigital.com/api/app")! }
    
}
