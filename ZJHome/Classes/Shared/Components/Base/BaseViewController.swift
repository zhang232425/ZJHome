//
//  BaseViewController.swift
//  ZJHome
//
//  Created by Jercan on 2022/10/20.
//

import UIKit
import ZJBase
import RxSwift
import RxCocoa
import RxSwiftExt
import Then
import SnapKit
import ZJExtension
import Action
import ZJHUD

class BaseViewController: ZJViewController {
        
    // MARK: - Property
    let disposeBag = DisposeBag()
    
    var hud: ZJHUDView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        automaticallyAdjustsScrollViewInsets = false
    }
    
    func doError(_ error: ActionError) {
        if case .underlyingError(let err) = error {
            ZJHUD.noticeOnlyText(err.localizedDescription)
        }
    }
    
    func doProgress(_ executing: Bool) {
        view.endEditing(true)
        if executing {
            hud?.hide()
            hud = ZJHUDView()
            hud?.showProgress(in: view)
        } else {
            hud?.hide()
        }
    }
    
    func doProgress(in showView: UIView?, executing: Bool) {
        view.endEditing(true)
        if executing {
            hud?.hide()
            hud = ZJHUDView()
            hud?.showProgress(in: showView)
        } else {
            hud?.hide()
        }
    }
    
    func doSuccess(_ success: String?, delay: TimeInterval = 2) {
        ZJHUD.noticeOnlyText(success, delay: delay)
    }
    
    deinit {
        hud?.hide()
    }

}

