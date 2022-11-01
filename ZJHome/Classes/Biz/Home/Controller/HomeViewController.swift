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
    private lazy var navBarView = HomeNavigationBarView()
    
    private lazy var topBgView = UIImageView().then {
        $0.image = UIImage.dd.named("home_top_two")
    }
    
    private lazy var scrollView = HomeScrollView()

    override func viewDidLoad() {
        super.viewDidLoad()
        config()
        setupViews()
        bindViewModel()
        //viewModel.requestLayout()
    }

}

private extension HomeViewController {
    
    func config() {
        view.backgroundColor = UIColor.backgroundColor
        navigationController?.isNavigationBarHidden = true
    }
    
    func setupViews() {
        
        navBarView.add(to: view).snp.makeConstraints {
            $0.top.left.right.equalToSuperview()
        }
        
        topBgView.add(to: view).snp.makeConstraints {
            $0.top.equalTo(navBarView.snp.bottom)
            $0.left.right.equalToSuperview()
            $0.height.equalTo(116.auto)
        }
        
    }
    
    func bindViewModel() {
        
        viewModel.homeLayoutModel.subscribe(onNext: {
            print($0.sections)
        }).disposed(by: disposeBag)
        
    }
    
}

private extension HomeViewController {
    
    
    
}
