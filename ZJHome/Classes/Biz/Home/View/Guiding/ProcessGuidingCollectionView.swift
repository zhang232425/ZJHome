//
//  ProcessGuidingCollectionView.swift
//  ZJHome
//
//  Created by Jercan on 2023/8/30.
//

import UIKit

class ProcessGuidingCollectionView: UICollectionView {
    
    var onDidEndDecelerating: ((Int, PageBehaviorOnEndDecelerating) -> ())?
    
    var itemSpacing = CGFloat(8)
    private let itemWidth = CGFloat(UIScreen.screenWidth - 60)
    private let itemHeight = CGFloat(112)
    private var lastIndex = 0
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumLineSpacing = 8.auto
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.itemSize = CGSize(width: itemWidth, height: itemHeight)
        flowLayout.sectionInset = .init(top: 0, left: 0, bottom: 0, right: 0)
        super.init(frame: frame, collectionViewLayout: flowLayout)
        delegate = self
//        isPagingEnabled = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

private extension ProcessGuidingCollectionView {
    
    func pageRefresh() {
        
        /**
         ceil(x)返回不小于x的最小整数值（然后转换为double型）。
         floor(x)返回不大于x的最大整数值。
         round(x)返回x的四舍五入整数值。
         */
        
        let index = Int(round(contentOffset.x / max(1, itemWidth)))
        
        if lastIndex == index {
            onDidEndDecelerating?(index, .staySame)
        } else if lastIndex < index {
            onDidEndDecelerating?(index, .increased)
        } else {
            onDidEndDecelerating?(index, .decreased)
        }
        
        lastIndex = index
    
    }
    
}

extension ProcessGuidingCollectionView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("点击了 - \(indexPath.item)")
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        pageRefresh()
    }
    
    /*
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var size = collectionView.bounds.size
        size.width -= itemSpacing + 0.5
        return size
    }
     */
    
}

//func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
//                    sizeForItemAt indexPath: IndexPath) -> CGSize {
//    var size = collectionView.bounds.size
//    size.width -= itemSpacing + 0.5 //为了右侧cell能显示出来
//    return size
//}


