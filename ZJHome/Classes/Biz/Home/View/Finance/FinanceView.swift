//
//  FinanceView.swift
//  ZJHome
//
//  Created by Jercan on 2023/10/27.
//

import UIKit

class FinanceView: FinanceBaseView {
    
    private var isFlashViewEmpty = false
    private var isHotNewsEmpty = false
    private var isCourseEmpty = false
    
    private lazy var titleLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 20, weight: .bold)
        $0.textColor = .init(hexString: "#333333")
    }
    
    private lazy var arrowImageView = UIImageView(image: UIImage.dd.named("home_item_more_icon"))
    
    private lazy var contentView = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 11
        $0.distribution = .fill
        $0.alignment = .fill
    }
    
    private lazy var newsFlashView = NewsFlashView().then {  // 快讯
        $0.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleFlashClick)))
    }
    
    private lazy var hotNewsView = HotNewsView() // 热门
    
    private lazy var courseView = FinanceClassView() // 学堂
    
    override func initialize() {
        
        let headerView = UIView().then {
            $0.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleHeaderClick)))
        }
        
        headerView.add(to: self).snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.left.right.equalToSuperview()
            $0.height.equalTo(54)
        }
        
        titleLabel.add(to: headerView).snp.makeConstraints {
            $0.top.equalTo(HomeScrollView.sharedItemTopMargin)
            $0.left.equalToSuperview().inset(16)
            $0.right.equalTo(-50)
        }
        
        arrowImageView.add(to: headerView).snp.makeConstraints {
            $0.centerY.equalTo(titleLabel)
            $0.right.equalToSuperview().inset(16)
            $0.width.height.equalTo(16)
        }
        
        contentView.add(to: self).snp.makeConstraints {
            $0.top.equalTo(headerView.snp.bottom)
            $0.left.right.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview()
        }
        
        setupSubviews()
    }
    
    private func setupSubviews() {
        
        if isFlashViewEmpty == false {
            contentView.addArrangedSubview(newsFlashView)
            newsFlashView.snp.makeConstraints {
                $0.left.right.equalToSuperview()
            }
        }
        
        if isHotNewsEmpty == false {
            contentView.addArrangedSubview(hotNewsView)
            hotNewsView.snp.makeConstraints {
                $0.left.right.equalToSuperview()
            }
        }
        
        if isCourseEmpty == false {
            contentView.addArrangedSubview(courseView)
            courseView.snp.makeConstraints {
                $0.left.right.equalToSuperview()
            }
        }
    }
    
    private func refresh(with data: FinanceItemData) {
        
        subviews.forEach{ $0.removeFromSuperview() }
        initialize()
        
        switch data {
        case .brief(let htmls):
            updateFlashView(htmls: htmls)
        case .course(let model):
            updateHotNewsView(model: model.news)
            updateCourseView(article: model.text, video: model.video)
        case .briefError:
            updateFlashView(htmls: [])
        case .courseError:
            updateHotNewsView(model: .init())
            updateCourseView(article: .init(), video: .init())
        }
    }
    
    private func updateFlashView(htmls: [String]) {
        
        isFlashViewEmpty = htmls.isEmpty
        
        contentView.removeArrangedSubview(newsFlashView)
        newsFlashView.removeFromSuperview()
        
        if htmls.isEmpty { return }
        
        contentView.insertArrangedSubview(newsFlashView, at: 0)
        newsFlashView.snp.makeConstraints {
            $0.left.right.equalToSuperview()
        }
        
        newsFlashView.refreshWith(htmls: htmls)
    }
    
    private func updateHotNewsView(model: FinanceCourseModel.HotNews) {
        
        isHotNewsEmpty = model.isEmpty
        
        contentView.removeArrangedSubview(hotNewsView)
        hotNewsView.removeFromSuperview()
        
        if model.isEmpty { return }
        
        let index = contentView.arrangedSubviews.isEmpty ? 0 : 1
        contentView.insertArrangedSubview(hotNewsView, at: index)
        hotNewsView.snp.makeConstraints {
            $0.left.right.equalToSuperview()
        }
        
        hotNewsView.setNewsTitle(model.title, id: model.newsId, type: model.column)
    }
    
    private func updateCourseView(article: FinanceCourseModel.Text, video: FinanceCourseModel.Video) {
        
        isCourseEmpty = article.isEmpty && video.isEmpty
        
        contentView.removeArrangedSubview(courseView)
        courseView.removeFromSuperview()
        
        if article.isEmpty, video.isEmpty { return }
        
        let index = contentView.arrangedSubviews.count
        contentView.insertArrangedSubview(courseView, at: index)
        courseView.snp.makeConstraints {
            $0.left.right.equalToSuperview()
        }
        
        courseView.updateWith(article: article, video: video)
    }
}

private extension FinanceView {
    
    @objc func handleHeaderClick() {
        
        HomeExtraEvent.goFinanceTab.post(by: self)
//        ReportEvent.financeMore.report()
    }
    
    @objc func handleFlashClick() {
        
        HomeExtraEvent.goFinanceTab.post(by: self)
//        ReportEvent.financeFlash.report()
    }
}

extension FinanceView: HomeRefreshableItemView {
    
    func refresh(with state: HomeItemState<FinanceItemData>) {
        
        switch state {
        case .loading:
            refreshWithLoadingState()
        case .data(let data):
            refresh(with: data)
        case .empty:
            refreshWithEmptyState()
        }
    }
}

extension FinanceView: HomeTitledItemView {
    
    func setTitle(_ title: String?) {
        titleLabel.text = title
    }
}
