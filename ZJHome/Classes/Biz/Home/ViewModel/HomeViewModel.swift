//
//  HomeViewModel.swift
//  Action
//
//  Created by Jercan on 2022/10/18.
//

import Action
import RxCocoa
import RxSwift
import ZJRequest

/*
final class HomeViewModel {
    
    /// 首页布局
    private(set) lazy var homeLayoutAction: Action<(), HomeLayoutModel> = .init {
        return Request.homeLayout()
    }
    
}
 */


final class HomeViewModel {
    
    private var layoutModel: HomeLayoutModel?
    
    /// 首页布局
    private var layoutAction: Action<(), HomeLayoutModel>!
    
    /// 引导步骤
    private var guideAction: Action<(), [HomeGuidingModel]>!
    
    /// banner数据
    private var bannerAction: Action<(), [HomeBannerModel]>!
    
    private let disposeBag = DisposeBag()

    init() {
        setupActions()
        bindData()
    }
    
}

private var bannerAction: Action<(), [HomeBannerModel]>!

private extension HomeViewModel {
    
    func setupActions() {
        
        /// 首页布局
        layoutAction = .init(workFactory: {
            Request.homeLayout().delay(.milliseconds(200), scheduler: MainScheduler.instance)
        })
        
        /// 引导步骤
        guideAction = .init(workFactory: { Request.guideProgresses() })
        
        /// banner数据
        bannerAction = .init(workFactory: { Request.bannerList() })
        
    }
    
    func bindData() {
        
        homeLayoutModel.subscribe(onNext: { [weak self] in
            self?.layoutModel = $0
            self?.requestItmesData()
        }).disposed(by: disposeBag)
        
    }
    
}

extension HomeViewModel {
    
    func requestLayout() {
        layoutAction.execute()
    }
    
}

private extension HomeViewModel {
    
    func requestItmesData() {
        
        guideAction.execute()
        bannerAction.execute()
        
    }
    
}

extension HomeViewModel {
    
    private var hasNoData: Bool { (layoutModel?.sections ?? []).isEmpty }
    
    /// 发生错误时，还未请求到布局
    var layoutErrorWithNoData: Observable<Error> {
        homeLayoutError.filter { [weak self] _ in (self?.hasNoData ?? false)}
    }
    
    var homeLayoutModel: Observable<HomeLayoutModel> { layoutAction.elements.share(replay: 1) }
    var homeLayoutError: Observable<Error> { layoutAction.underlyingError.map(LayoutError.parse) }
    var layoutExecuting: Observable<Bool> {
        layoutAction.executing.map { [weak self] in $0 && (self?.layoutModel == nil) }
            .filter { $0 == true }
    }
    
    /// 引导步骤
    var homeGuidingModel: Observable<[HomeGuidingModel]> { guideAction.elements }
    var homeGuidingError: Observable<Error> { guideAction.underlyingError }
    
    /// banner数据
    var homeBannerModel: Observable<[HomeBannerModel]> { bannerAction.elements }
    var homeBannerError: Observable<Error> { bannerAction.underlyingError }
    
}

import Moya
import Alamofire

private enum LayoutError: LocalizedError {
    
    case networkError
    case requestTimeOut
    case requestFailed
    
    static func parse(error: Error) -> LayoutError {
        if case MoyaError.underlying(let underlying, _) = error,
           case AFError.sessionTaskFailed(let err) = underlying {
            switch (err as NSError).code {
            case NSURLErrorNotConnectedToInternet:
                return .networkError
            case NSURLErrorTimedOut:
                return .requestTimeOut
            default: break
            }
        }
        return .requestFailed
    }
    
    var errorDescription: String? {
        switch self {
        case .networkError:     return Locale.networkOffline.localized
        case .requestTimeOut:   return Locale.requestTimedOut.localized
        case .requestFailed:    return Locale.requestFailed.localized
        }
    }
}





 

 

