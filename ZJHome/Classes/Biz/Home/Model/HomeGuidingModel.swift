//
//  HomeGuidingModel.swift
//  ZJHome
//
//  Created by Jercan on 2023/6/19.
//

import Foundation
import HandyJSON

struct HomeGuidingListModel: HandyJSON {
    
    var taskList = [HomeGuidingModel]()
    
    mutating func didFinishMapping() {
        
        if taskList.allSatisfy({ $0.isFinished }) {
            taskList.removeAll()
            return
        }
        
        for (i, item) in taskList.enumerated() where item.isFinished {
            taskList[i].isButtonEnabled = false
        }
        
        if let firstUnFinished = taskList.firstIndex(where: { !$0.isFinished }) {
            taskList[firstUnFinished].isButtonEnabled = true
            for j in (firstUnFinished + 1) ..< taskList.count {
                taskList[j].isButtonEnabled = false
            }
        }

    }
    
}

struct HomeGuidingModel: HandyJSON {
    
    enum Task: Int, HandyJSONEnum {
        case unknown         = -99
        case register        = 1      // 注册
        case certify         = 5      // KYC认证
        case firstP2PLend    = 10     // P2P首投
    }
    
    /// 本地逻辑，`去完成`按钮是否可点击
    var isButtonEnabled = false
    
    var type = Task.unknown
    
    var title = ""
    
    var highlightWords = [String]()
    
    var isFinished = false
    
    var buttonTitle = ""
    
    var imageUrl = ""
    
    mutating func mapping(mapper: HelpingMapper) {
        mapper <<< title <-- "content"
        mapper <<< highlightWords <-- "keyWord"
        mapper <<< isFinished <-- "finish"
        mapper <<< buttonTitle <-- "button"
    }
    
}

extension Array where Element == HomeGuidingModel {
    /// 第一个未完成的index
    var firstUnfinishedIndex: Int? {
        self.firstIndex(where: { $0.isFinished == false })
    }
}

extension HomeGuidingModel {
    
    var attributedTitle: NSAttributedString {
        let attrStr = NSMutableAttributedString(string: title)
        let fullRange = NSMakeRange(0, title.count)
        attrStr.addAttribute(.foregroundColor, value: UIColor(hexString: "#333333"), range: fullRange)
        attrStr.addAttribute(.font, value: UIFont.regular12, range: fullRange)
        
        for word in highlightWords {
            let colorRange = attrStr.mutableString.range(of: word)
            if colorRange.location != NSNotFound {
                attrStr.addAttribute(.foregroundColor, value: UIColor(hexString: "#FF7D0F"), range: colorRange)
                attrStr.addAttribute(.font, value: UIFont.bold14, range: colorRange)
            }
        }
        return attrStr
    }
    
}


