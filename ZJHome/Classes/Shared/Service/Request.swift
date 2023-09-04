//
//  Request.swift
//  ZJHome
//
//  Created by Jercan on 2022/10/19.
//

import RxSwift
import ZJRequest
import SwiftyJSON
import Moya
import ZJValidator

struct Request {}

extension Request {
    
    /// 首页布局
    static func homeLayout() -> Single<HomeLayoutModel> {
        HomeAPI.homeLayout.rx.request()
            .ensureResponseStatus()
            .mapObject(ZJRequestResult<HomeLayoutModel>.self)
            .map { $0.data ?? .init() }
    }
    
    /// 引导步骤
    static func guideProgresses() -> Single<[HomeGuidingModel]> {
        HomeAPI.guideProgress.rx.request()
            .ensureResponseStatus()
            .mapObject(ZJRequestResult<HomeGuidingListModel>.self)
            .map { $0.data?.taskList ?? [] }
    }
    
    /// banner数据
    static func bannerList() -> Single<[HomeBannerModel]> {
        HomeAPI.banner.rx.request()
            .ensureResponseStatus()
            .mapObject(_ListModel<HomeBannerModel>.self)
            .map { ($0.data?.content ?? []).sortedBy(\.order) }
    }
    
}

extension PrimitiveSequence where Trait == SingleTrait, Element == Moya.Response {
    
    func ensureResponseStatus() -> Single<JSON> {
        mapSwiftyJSON().flatMap { (json) -> Single<JSON> in
            let result = ZJResponseCodeValidator.validate(success: json["success"].boolValue, code: json["errCode"].string, msg: json["errMsg"].string)
            guard result.success else {
                var userInfo = [String: Any]()
                userInfo[NSLocalizedDescriptionKey] = result.message
                userInfo["errorCode"] = result.code
                throw NSError(domain: "RequestFailureDomain", code: -1, userInfo: userInfo)
            }
            return .just(json)
        }
    }
    
}

extension Request {
    
    static func isNetworkReachable() -> Single<Bool> {
        return .create { single -> Disposable in
            if ZJNetworkMonitor.shared.isReachable {
                single(.success(true))
            } else {
                single(.success(false))
            }
            return Disposables.create {}
        }
    }
    
}

import HandyJSON

private typealias _ListModel<T> = ZJRequestResult<ModelsContainer<T>> // data.content 是`T`类型数组

private struct ModelsContainer<T>: HandyJSON {
    
    var content = [T]()
}

private extension Array {
    
    func sortedBy(_ keypath: KeyPath<Element, Int>) -> Self {
        return sorted { (e1, e2) -> Bool in
            e1[keyPath: keypath] < e2[keyPath: keypath]
        }
    }
}
