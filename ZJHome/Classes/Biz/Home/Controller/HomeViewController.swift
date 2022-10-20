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
    private lazy var testBtn = UIButton(type: .system).then {
        $0.setTitle("Test", for: .normal)
        $0.addTarget(self, action: #selector(testClick), for: .touchUpInside)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        bindViewModel()
    }

}

private extension HomeViewController {
    
    func setupViews() {
        
        testBtn.add(to: view).snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        
    }
    
    func bindViewModel() {
        
        viewModel.homeLayoutAction.elements.subscribe(onNext: {
            print("首页布局 ------ \($0)")
        }).disposed(by: disposeBag)
        
    }
    
}

private extension HomeViewController {
    
    @objc func testClick() {
        
        viewModel.homeLayoutAction.execute()
        
    }
    
}
