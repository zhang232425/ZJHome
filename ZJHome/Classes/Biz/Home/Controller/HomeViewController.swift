//
//  HomeViewController.swift
//  Pods-ZJHome_Example
//
//  Created by Jercan on 2022/10/18.
//

import UIKit
import RxSwift

class HomeViewController: BaseViewController {
    
    // MARK: - Property
    private let viewModel = HomeViewModel()
    
    // MARK: - Lazy Load
    private lazy var titleView = HomeNavigationBarView()
    
    private lazy var scrollView = HomeScrollView().then {
        $0.alwaysBounceVertical = true
        $0.refreshClick = { [weak self] in self?.viewModel.requestLayout() }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        config()
        setupViews()
        bindViewModel()
        viewModel.requestLayout()
    }

}

private extension HomeViewController {
    
    func config() {
        view.backgroundColor = .white
        navigationController?.isNavigationBarHidden = true
    }
    
    func setupViews() {
        
        titleView.add(to: view).snp.makeConstraints {
            $0.top.left.right.equalToSuperview()
        }
        
        scrollView.add(to: view).snp.makeConstraints {
            $0.top.equalTo(titleView.snp.bottom)
            $0.left.bottom.right.equalToSuperview()
        }
        
    }
    
    func bindViewModel() {
        
        scrollView.rx.addPullToRefresh
            .subscribeNext(weak: self, type(of: self).handlePull)
            .disposed(by: disposeBag)
        
        Observable.merge(viewModel.homeBannerModel.map{_ in},
                         viewModel.homeBannerError.map{_ in})
        .bind(to: scrollView.rx.endPullToRefresh)
        .disposed(by: disposeBag)
        
        viewModel.layoutExecuting.subscribe(onNext: { [weak self] _ in
            self?.scrollView.setState(.loading)
        }).disposed(by: disposeBag)
        
        viewModel.homeLayoutModel.subscribe(onNext: { [weak self] model in
            self?.scrollView.setState(.layout(model.sections))
        }).disposed(by: disposeBag)
        
        viewModel.homeLayoutModel.subscribe(onNext: { [weak self] model in
            let entries = HomeItemState(data: model.quickEntries)
            self?.scrollView.update(type: .quickEntry, model: entries)
        }).disposed(by: disposeBag)
        
        viewModel.layoutErrorWithNoData.subscribe(onNext: { [weak self] _ in
            self?.scrollView.setState(.failure)
        }).disposed(by: disposeBag)
        
        
        viewModel.homeGuidingModel.subscribe(onNext: { [weak self] in
            self?.scrollView.update(type: .guideProgress, model: HomeItemState(data: $0))
        }).disposed(by: disposeBag)
        
        viewModel.homeGuidingError.subscribe(onNext: { [weak self] _ in
            self?.scrollView.update(type: .guideProgress, model: AnyHomeItemState.empty)
        }).disposed(by: disposeBag)
        
        
        viewModel.homeBannerModel.subscribe(onNext: { [weak self] in
            self?.scrollView.update(type: .banner, model: HomeItemState(data: $0))
        }).disposed(by: disposeBag)
        
        viewModel.homeBannerError.subscribe(onNext: { [weak self] _ in
            self?.scrollView.update(type: .banner, model: AnyHomeItemState.empty)
        }).disposed(by: disposeBag)
        
    }
    
}

private extension HomeViewController {
    
    func handlePull(_: Void) {
        viewModel.requestLayout()
    }
    
}
