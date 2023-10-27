//
//  HomeCollectionView.swift
//  ZJHome
//
//  Created by Jercan on 2023/10/26.
//

import UIKit

class HomeCollectionView: UICollectionView {
    
    var itemSpacing = CGFloat(8)
    
    var onDidEndDecelerating: ((Int, PageBehaviorOnEndDecelerating) -> ())?
    
    var onDidSelectIndex: ((Int) -> ())?
    
    private var lastIndex = 0

    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumLineSpacing = itemSpacing
        flowLayout.sectionInset = .init(top: 0, left: 0, bottom: 0, right: itemSpacing)
        flowLayout.scrollDirection = .horizontal
        super.init(frame: frame, collectionViewLayout: flowLayout)
        isPagingEnabled = true
        backgroundColor = .white
        showsHorizontalScrollIndicator = false
        self.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

private extension HomeCollectionView {
    
    func notifyPageRefresh() {
        
        let index = Int(round(contentOffset.x / max(1, bounds.width)))
        
        if lastIndex == index {
            onDidEndDecelerating?(index, .staySame)
        } else if lastIndex < index {
            onDidEndDecelerating?(index, .increased)
        } else {
            onDidEndDecelerating?(index, .decreased)
        }
        
    }
    
}

extension HomeCollectionView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var size = collectionView.bounds.size
        size.width -= itemSpacing + 0.5 // 为了右侧cell能显示出来
        return size
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        notifyPageRefresh()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        onDidSelectIndex?(indexPath.item)
    }
    
}
