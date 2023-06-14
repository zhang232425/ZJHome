//
//  HomeViewController.swift
//  Pods-ZJHome_Example
//
//  Created by Jercan on 2022/10/18.
//

import UIKit

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
        
        viewModel.layoutExecuting.subscribe(onNext: { [weak self] _ in
            self?.scrollView.setState(.loading)
        }).disposed(by: disposeBag)
        
        viewModel.homeLayoutModel.subscribe(onNext: { [weak self] model in
            self?.scrollView.setState(.layout(model.sections))
        }).disposed(by: disposeBag)
        
    }
    
}


