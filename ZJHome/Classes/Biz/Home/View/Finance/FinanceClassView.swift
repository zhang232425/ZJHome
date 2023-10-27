//
//  FinanceClassView.swift
//  ZJHome
//
//  Created by Jercan on 2023/10/27.
//

import UIKit
import ZJExtension

class FinanceClassView: FinanceItemBaseView {

    private var articleId:  String?
    private var articleType:String?
    private var videoId:    String?
    private var videoType:  String?
    
    private lazy var iconImageView = UIImageView().then {
        $0.image = UIImage.dd.named("finance_class_id")
    }
    
    private lazy var contentView = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 0
        $0.distribution = .fill
        $0.alignment = .fill
    }

    override func initialize() {
        super.initialize()
        
        let topView = UIImageView(image: UIImage.dd.named("finance_class_bg"))
        
        topView.add(to: self).snp.makeConstraints {
            $0.left.right.top.equalToSuperview()
            $0.height.equalTo(39)
        }
        
        iconImageView.add(to: topView).snp.makeConstraints {
            $0.left.equalTo(12)
            $0.centerY.equalToSuperview()
        }
        
        contentView.add(to: self).snp.makeConstraints {
            $0.top.equalTo(topView.snp.bottom)
            $0.left.right.bottom.equalToSuperview()
        }
        
        setupSubviews()
    }

    private func setupSubviews() {
        
        let classNewsView = ClassNewsView()
        contentView.addArrangedSubview(classNewsView)
        classNewsView.snp.makeConstraints {
            $0.left.right.equalToSuperview()
        }
        
        let classVideoView = ClassVideoView()
        contentView.addArrangedSubview(classVideoView)
        classVideoView.snp.makeConstraints {
            $0.left.right.equalToSuperview()
        }
    }
    
    @objc private func handleArticleClick() {
        
        if let id = articleId, let type = articleType {
            HomeExtraEvent.clickFinanceDetail(id: id, type: type).post(by: self)
//            ReportEvent.financeCourse.report()
        }
    }
    
    @objc private func handleVideoClick() {
        
        if let id = videoId, let type = videoType {
            HomeExtraEvent.clickFinanceVideo(id: id, type: type).post(by: self)
//            ReportEvent.financeCourse.report()
        }
    }
}

extension FinanceClassView {
    
    func updateWith(article: FinanceCourseModel.Text, video: FinanceCourseModel.Video) {
        
        contentView.arrangedSubviews.forEach {
            contentView.removeArrangedSubview($0)
            $0.removeFromSuperview()
        }
        if !article.id.isEmpty {
            articleId = article.id
            articleType = article.column
            let classNewsView = ClassNewsView().then {
                $0.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleArticleClick)))
                $0.contentLabel.text = article.title
                $0.readCountLabel.text =  article.count
                $0.imageView.setImageWith(url: article.imageUrl,
                                          placeholderImage: UIImage.dd.named("home_news_placeholder"))
                $0.iconImageView.isHidden = !article.isShowIcon
                $0.readCountLabel.isHidden =  !article.isShowIcon
            }
            contentView.addArrangedSubview(classNewsView)
            classNewsView.snp.makeConstraints {
                $0.left.right.equalToSuperview()
            }
        }
        
        if !video.id.isEmpty {
            videoId = video.id
            videoType = video.column
            let classVideoView = ClassVideoView().then {
                $0.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleVideoClick)))
                $0.titleLabel.text = video.title
                $0.readCountLabel.text = video.videoCount
                $0.setVideoCoverImage(url: video.imageUrl)
                $0.setVideoPlay(url: video.videoUrl)
                $0.iconImageView.isHidden = !video.isShowIcon
                $0.readCountLabel.isHidden =  !video.isShowIcon
            }
            contentView.addArrangedSubview(classVideoView)
            classVideoView.snp.makeConstraints {
                $0.left.right.equalToSuperview()
            }
        }
    }
    
}

private class ClassNewsView: FinanceBaseView {
    
    private(set) lazy var contentLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 14, weight: .medium)
        $0.textColor = .init(hexString: "#333333")
        $0.numberOfLines = 3
    }
    
    private(set) lazy var readCountLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 11, weight: .regular)
        $0.textColor = .init(hexString: "#999999")
    }
    
    private(set) lazy var iconImageView = UIImageView().then {
        $0.image = UIImage.dd.named("icon-eyes")
        $0.isHidden = true
    }
    
    private(set) lazy var imageView = UIImageView().then {
        $0.layer.cornerRadius = 4
        $0.layer.masksToBounds = true
    }
    
    override func initialize() {
        
        let leftView = UIView()
        
        leftView.add(to: self).snp.makeConstraints {
            $0.top.greaterThanOrEqualToSuperview().inset(15)
            $0.left.equalToSuperview().inset(12)
            $0.centerY.equalToSuperview()
            $0.bottom.lessThanOrEqualToSuperview().inset(16)
        }
        
        contentLabel.add(to: leftView).snp.makeConstraints {
            $0.top.left.right.equalToSuperview()
        }
        
        readCountLabel.add(to: leftView).snp.makeConstraints {
            $0.top.equalTo(contentLabel.snp.bottom).offset(13)
            $0.left.equalToSuperview()
            $0.bottom.lessThanOrEqualToSuperview().inset(0)
        }
        
        iconImageView.add(to: leftView).snp.makeConstraints {
            $0.left.equalTo(readCountLabel.snp.right).offset(4)
            $0.centerY.equalTo(readCountLabel)
        }
        
        imageView.add(to: self).snp.makeConstraints {
            $0.top.greaterThanOrEqualToSuperview().inset(15)
            $0.centerY.equalToSuperview()
            $0.right.equalToSuperview().inset(12)
            $0.left.equalTo(leftView.snp.right).offset(12)
            $0.bottom.lessThanOrEqualToSuperview().inset(16)
            $0.width.equalTo(102)
            $0.height.equalTo(76)
        }
        
        UIView().add(to: self).then {
            $0.backgroundColor = .init(hexString: "#F0F0F0")
        }.snp.makeConstraints {
            $0.left.right.equalToSuperview().inset(12)
            $0.bottom.equalToSuperview()
            $0.height.equalTo(1)
        }
        
    }
    
}

private class ClassVideoView: FinanceBaseView {
    
    private(set) lazy var titleLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 14, weight: .medium)
        $0.textColor = .init(hexString: "#333333")
        $0.numberOfLines = 3
    }

    private(set) lazy var readCountLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 11, weight: .regular)
        $0.textColor = .init(hexString: "#999999")
    }
    
    private(set) lazy var iconImageView = UIImageView().then {
        $0.image = UIImage.dd.named("icon-eyes")
        $0.isHidden = true
    }
    
    fileprivate var videoView: UIView? {
        let homevc = UIApplication.shared.topViewController as? HomeViewController
        let view = homevc?.videoPlayer.view
        view?.layer.cornerRadius = 4
        view?.layer.masksToBounds = true
        return view
    }
    
    override func initialize() {
        
        titleLabel.add(to: self).snp.makeConstraints {
            $0.top.equalToSuperview().inset(15)
            $0.left.right.equalToSuperview().inset(12)
        }
        
        if let videoView = videoView {
            videoView.add(to: self).snp.makeConstraints {
                $0.top.equalTo(titleLabel.snp.bottom).offset(9)
                $0.left.right.equalToSuperview().inset(12)
                $0.height.equalTo(videoView.snp.width).multipliedBy(0.55)
            }
            
            readCountLabel.add(to: self).snp.makeConstraints {
                $0.top.equalTo(videoView.snp.bottom).offset(8)
                $0.left.equalTo(titleLabel)
                $0.bottom.equalToSuperview().inset(17)
            }
            
            iconImageView.add(to: self).snp.makeConstraints {
                $0.left.equalTo(readCountLabel.snp.right).offset(4)
                $0.centerY.equalTo(readCountLabel)
            }
        }
    }
    
    func setVideoCoverImage(url: String?) {
        
        let homevc = UIApplication.shared.topViewController as? HomeViewController
        let player = homevc?.videoPlayer
        player?.coverView.setCoverImageUrl(url: url)
        
    }
    
    func setVideoPlay(url: String?) {
        
        let homevc = UIApplication.shared.topViewController as? HomeViewController
        let player = homevc?.videoPlayer
        player?.setVideoUrl(url: url)
        
    }
}
