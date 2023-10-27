//
//  FinanceCourseModel.swift
//  ZJHome
//
//  Created by Jercan on 2023/10/27.
//

import HandyJSON

struct FinanceCourseModel: HandyJSON {
    
    /// 理财课堂头条
    struct HotNews: HandyJSON {
        var newsId = ""
        var column = ""
        var title = ""
        
        var isEmpty: Bool { newsId.isEmpty || title.isEmpty }
    }
    
    /// 理财课堂文章
    struct Text: HandyJSON {
        var id = ""
        var column = ""
        var title = ""
        var author = ""
        var readCount = 0
        var imageUrl = ""
        
        mutating func mapping(mapper: HelpingMapper) {
            mapper <<< imageUrl <-- "thumbnail"
        }
        
        var isShowIcon : Bool {
           return readCount > 0 ? true : false
        }
        
        var isEmpty: Bool { id.isEmpty || title.isEmpty }
        
        var count : String {
            
            let number : Double = Double(readCount)
            
            let sign = ((number < 0) ?"-" :"" )
            let num = fabs(number)

            if (num < 1000.0){
                return String(format:"\(sign)%g", num)
            }
            
            if num > 10000000 {
                return "10M+"
            }else{
                let exp: Int = Int(log10(num)/3.0)
                let units: [String] = ["K","M","B","T"]
                let tempNum: Double = num / (pow(1000.0,Double(exp)) / 10 )
                let result = Int(ceilf(Float(tempNum)))
                let roundedNum = Double(result) / 10.0
                return String(format:"\(sign)%g\(units[exp-1])", roundedNum)
            }
        }
    }
    
    /// 理财课堂视频
    struct Video: HandyJSON {
        
        var id = ""
        var column = ""
        var title = ""
        var author = ""
        var readCount = 0
        var imageUrl = ""
        var videoUrl = ""
        
        mutating func mapping(mapper: HelpingMapper) {
            mapper <<< imageUrl <-- "thumbnail"
            mapper <<< videoUrl <-- "url"
        }
        
        var isEmpty: Bool { id.isEmpty || title.isEmpty }
        
        var isShowIcon : Bool {
           return readCount > 0 ? true : false
        }
        
        var videoCount : String {
            
            let number : Double = Double(readCount)
            
            let sign = ((number < 0) ?"-" :"" )
            let num = fabs(number)

            if (num < 1000.0){
                return String(format:"\(sign)%g", num)
            }

            if num > 10000000 {
                return "10M+"
            }else{
                let exp: Int = Int(log10(num)/3.0)
                let units: [String] = ["K","M","B","T"]
    //            var roundedNum: Double = round(10 * num / pow(1000.0,Double(exp))) / 10
                let tempNum: Double = num / (pow(1000.0,Double(exp)) / 10 )
                let result = Int(ceilf(Float(tempNum)))
                let roundedNum = Double(result) / 10.0
                return String(format:"\(sign)%g\(units[exp-1])", roundedNum)
            }
        }
    }
    
    var news = HotNews()
    
    var text = Text()
    
    var video = Video()
    
    mutating func mapping(mapper: HelpingMapper) {
        mapper <<< text <-- "financeClassText"
        mapper <<< video <-- "financeClassVideo"
    }
    
}

enum FinanceItemData {
    
    /// 快讯
    case brief(htmls: [String])
    
    case briefError
    
    /// 学堂
    case course(FinanceCourseModel)
    
    case courseError
}
