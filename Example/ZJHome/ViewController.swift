//
//  ViewController.swift
//  ZJHome
//
//  Created by zhang232425 on 09/17/2022.
//  Copyright (c) 2022 zhang232425. All rights reserved.
//

import UIKit
import ZJRoutableTargets
import ZJBase

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func homeClick() {
        
        if let vc = ZJHomeRoutableTarget.home.viewController {
            present(ZJNavigationController(rootViewController: vc), animated: true)
        }
        
    }
    
    @IBAction func loginClick() {
        print("-----登录")
    }
    

}

