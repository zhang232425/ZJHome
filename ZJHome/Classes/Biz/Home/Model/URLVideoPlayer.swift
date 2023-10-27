//
//  URLVideoPlayer.swift
//  ZJHome
//
//  Created by Jercan on 2023/10/27.
//

import AVFoundation

class URLVideoPlayer {
    
    enum State {
        case stop
        case playing
    }
    
    var onStateChanged: ((State) -> ())?
    
    var onFirstFrameReady: (() -> ())? {
        get { videoView.onReadyForDisplay }
        set { videoView.onReadyForDisplay = newValue }
    }
    
    private(set) var state = State.stop {
        didSet {
            if state != oldValue {
                onStateChanged?(state)
            }
        }
    }
    
    private let player: AVPlayer
    
    private let videoView: VideoView
    
    private var rateObservation: NSKeyValueObservation?
    
    init() {
        player = .init(playerItem: nil)
        videoView = .init(frame: .zero, player: player)
        
        rateObservation = player.observe(\.rate, options: [.new], changeHandler: { [weak self] (obj, change) in
            let rate = change.newValue ?? 0
            if rate > 0, obj.error == nil {
                self?.state = .playing
            } else {
                self?.state = .stop
            }
        })
    }
    
    deinit {
        debugPrint("\(String(describing: self)) deinit")
    }
}

extension URLVideoPlayer {
    
    var view: UIView { videoView }
    
    var isMuted: Bool {
        get { player.isMuted }
        set { player.isMuted = newValue }
    }
}

extension URLVideoPlayer {
    
    func play(urlString: String?) {
        
        guard let string = urlString, let url = URL(string: string) else { return }
        
        let item = AVPlayerItem(url: url)
        player.replaceCurrentItem(with: item)
        player.play()
    }
    
    func resume() {
        
        if state == .stop, player.currentItem != nil {
            player.play()
        }
    }
    
    func pause() {
        
        if state == .playing {
            player.pause()
        }
    }
    
    func stop() {
        
        player.pause()
        player.seek(to: CMTime(value: .zero, timescale: 0))
    }
}

private class VideoView: UIView {
    
    var onReadyForDisplay: (() -> ())? // 首帧就绪
    
    private let videoLayer: AVPlayerLayer
    
    private var isReadyObservation: NSKeyValueObservation?
    
    init(frame: CGRect, player: AVPlayer) {
        videoLayer = .init(player: player)
        super.init(frame: frame)
        videoLayer.frame = .init(origin: .zero, size: frame.size)
        videoLayer.videoGravity = .resizeAspectFill
        layer.addSublayer(videoLayer)
        
        isReadyObservation = videoLayer.observe(\.isReadyForDisplay, options: .new, changeHandler: { [weak self] in
            let isReady = $1.newValue ?? false
            if isReady {
                self?.onReadyForDisplay?()
            }
        })
    }
    
    required init?(coder: NSCoder) { fatalError() }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        videoLayer.frame = .init(origin: .zero, size: frame.size)
    }
}

