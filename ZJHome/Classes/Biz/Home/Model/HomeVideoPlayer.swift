//
//  HomeVideoPlayer.swift
//  ZJHome
//
//  Created by Jercan on 2023/10/27.
//

import RxSwift
import ZJRequest
import Foundation

final class HomeVideoPlayer: URLVideoPlayer {
    
    private(set) lazy var coverView = HomeVideoCoverView()
    
    private let scrollEndHandler = _ScrollEndHandler()
    
    private var disposeBag = DisposeBag()
    
    private var currentVideoUrl: String?
    
    override init() {
        super.init()
        
        coverView.add(to: view).snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        configCoverView()
        isMuted = true // 静音
        ZJNetworkMonitor.shared.startListening()
    }
    
    deinit {
        ZJNetworkMonitor.shared.stopListening()
    }
}

extension HomeVideoPlayer {
    
    func setVideoUrl(url: String?) {
        
        currentVideoUrl = url
        
        if shouldAutoPlay {
            disposeBag = .init()
            setupAutoPlay(disposeBag)
            play(urlString: currentVideoUrl)
            pause() // start buffering...
        }
    }
    
    /// 手动播放(强制播放)
    func play() {
        
        play(urlString: currentVideoUrl)
    }
}

private extension HomeVideoPlayer {
    
    var shouldAutoPlay: Bool {
        let vcOK  = UIApplication.shared.topViewController is HomeViewController
        let netOK = ZJNetworkMonitor.shared.networkState == .wifi
        return vcOK && netOK
    }
    
    func setupAutoPlay(_ bag: DisposeBag) {
        
        let firstFrameReady = Observable<()>.create { [weak self] obs -> Disposable in
            self?.onFirstFrameReady = {
                obs.onNext(())
            }
            return Disposables.create()
        }
        
        let selector = #selector(_ScrollEndHandler.handleScrollDelayingEnd)
        let scrollEnd = scrollEndHandler.rx.methodInvoked(selector)
        
        Observable.zip(firstFrameReady, scrollEnd).subscribe(onNext: { [weak self] _ in
            self?.resume()
        }).disposed(by: bag)
    }
    
    func configCoverView() {
        
        onStateChanged = { [weak self] in
            switch $0 {
            case .stop:
                self?.coverView.isHidden = false
            case .playing:
                self?.coverView.isHidden = true
            }
        }
    }
}

private class _ScrollEndHandler: NSObject {
    
    private var scrollObserver: CFRunLoopObserver? // 监听滚动停止
    
    override init() {
        super.init()
        observeRunloop()
    }
    
    deinit {
        unObserveRunloop()
    }
    
    func observeRunloop() {
        
        guard let allocator = CFAllocatorGetDefault()?.takeUnretainedValue() else { return }
        let flags = CFRunLoopActivity.exit.rawValue
        scrollObserver = CFRunLoopObserverCreateWithHandler(allocator, flags, true, 0) { [weak self] (_,_) in
            self?.onScrollEnd()
        }
        CFRunLoopAddObserver(CFRunLoopGetMain(), scrollObserver, .uiTracking)
    }
    
    func unObserveRunloop() {
        
        if let observer = scrollObserver {
            CFRunLoopRemoveObserver(CFRunLoopGetMain(), observer, .uiTracking)
        }
    }
    
    func onScrollEnd() {
        
        let selector = #selector(handleScrollDelayingEnd)
        NSObject.cancelPreviousPerformRequests(withTarget: self, selector: selector, object: nil)
        self.perform(selector, with: nil, afterDelay: 5, inModes: [RunLoopMode.commonModes])
    }
    
    @objc func handleScrollDelayingEnd() {}
}

private extension CFRunLoopMode {
    
    static var uiTracking: CFRunLoopMode { .init(rawValue: RunLoop.Mode.UITrackingRunLoopMode.rawValue as CFString) }
    
}

