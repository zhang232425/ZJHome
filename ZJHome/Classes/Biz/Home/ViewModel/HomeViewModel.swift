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
import ZJLoginManager

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
    
    /// 新手产品
    private var noviceProductsAction: Action<(), HomeProductsModel>!
    
    /// 推荐产品
    private var recommendProductsAction: Action<(), HomeProductsModel>!
    
    /// banner数据
    private var bannerAction: Action<(), [HomeBannerModel]>!
    
    /// 待支付订单
    private var unpaidNoticeAction: Action<(), HomeUnpaidConfigModel>!
    
    /// 首页财经快讯
    private var financeBriefAction: Action<(), [String]>!
    
    /// 首页理财学堂
    private var financeCourseAction: Action<(), FinanceCourseModel>!
    
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
        
        /// 新手产品
        noviceProductsAction = .init(workFactory: { Request.noviceProductList() })
                
        /// 推荐产品
        recommendProductsAction = .init(workFactory: { Request.recommendProductList() })
        
        /// banner数据
        bannerAction = .init(workFactory: { Request.bannerList() })
        
        /// 待支付订单
        unpaidNoticeAction = .init(workFactory: { Request.unpaidCountNotice() })
        
        /// 首页财经快讯
        financeBriefAction = .init(workFactory: { Request.homeFinanceBrief() })
        
        /// 首页理财学堂
        financeCourseAction = .init(workFactory: { Request.homeFinanceCourse() })
        
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
    
    func requestUnpaidNotice() {
        if ZJLoginManager.shared.isLogin {
            unpaidNoticeAction.execute()
        }
    }
    
}

private extension HomeViewModel {
    
    func requestItmesData() {
        
        guideAction.execute()
        noviceProductsAction.execute()
        recommendProductsAction.execute()
        bannerAction.execute()
        financeBriefAction.execute()
        financeCourseAction.execute()
        
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
    
    /// 新手产品
    var noviceProductsModel: Observable<HomeProductsModel> { noviceProductsAction.elements }
    var noviceProductsError: Observable<Error> { noviceProductsAction.underlyingError }
    
    /// 推荐产品
    var recommendProductsModel: Observable<HomeProductsModel> { recommendProductsAction.elements }
    var recommendProductsError: Observable<Error> { recommendProductsAction.underlyingError }
    
    /// banner数据
    var homeBannerModel: Observable<[HomeBannerModel]> { bannerAction.elements }
    var homeBannerError: Observable<Error> { bannerAction.underlyingError }
    
    /// 待支付定单数据
    var unpaidNoticeModel: Observable<HomeUnpaidConfigModel> { unpaidNoticeAction.elements }
    
    /// 首页财经快讯
    var financeBriefModel: Observable<[String]> { financeBriefAction.elements }
    var financeBriefError: Observable<Error> { financeBriefAction.underlyingError }
    
    /// 首页理财学堂
    var financeCourseModel: Observable<FinanceCourseModel> { financeCourseAction.elements }
    var financeCourseError: Observable<Error> { financeCourseAction.underlyingError }
    
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





 

 

