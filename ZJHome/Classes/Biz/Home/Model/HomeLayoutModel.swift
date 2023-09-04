//
//  HomeModel.swift
//  Action
//
//  Created by Jercan on 2022/10/18.
//

import HandyJSON

struct HomeLayoutModel: HandyJSON {
    
    /// 首页功能数据模型
    struct SectionModel: HandyJSON {
        
        enum SectionType: String, HandyJSONEnum {
            case unknown    = ""
            case quickEntry = "QA"
            case guide      = "HA"
            case novice     = "NUA"
            case recommend  = "RA"
            case banner     = "BA"
            case finance    = "CA"
            case disclosure = "MA"
        }
        
        /// 类型
        var type = SectionType.unknown
        
        /// 是否禁用 0:禁用 1:启用
        var status = 0
        
        mutating func mapping(mapper: HelpingMapper) {
            mapper <<< type     <-- "moduleCode"
        }
        
    }
    
    /// 首页快捷入口数据模型
    struct QuickEntryModel: HandyJSON {
        
        enum QuickEntryType: Int, HandyJSONEnum {
            case unknown     = -99
            case p2pProducts = 1 // P2P定期
            case finance     = 2 // 财经
            case fund        = 3 // 基金
            case gold        = 4 // 黄金
            case community   = 6 // 社区
        }
        
        enum QuickEntryRoute: Int, HandyJSONEnum {
            case web    = 1
            case native = 2
            case nop    = 3
        }
        
        var id = ""
        
        /// 本地跳转路径
        var nativePath = QuickEntryType.unknown
        
        /// 跳转
        var route = QuickEntryRoute.nop
        
        /// 显示标题
        var title = ""
    
        /// 链接
        var url = ""
        
        var iconImgUrl = ""
        
        var dynamicIconUrl = ""
        
        mutating func mapping(mapper: HelpingMapper) {
            mapper <<< nativePath <-- "originalPath"
            mapper <<< route      <-- "quickProperty"
            mapper <<< title      <-- "copywriting"
            mapper <<< iconImgUrl <-- "thumbnailUrl"
        }
        
    }
    
    /// 公告数据模型
    struct NoticeModel: HandyJSON {
        var id = ""
        //标题
        var title = ""
        //跳转链接
        var appJumpUrl = ""
    }
    
    /// 合规声明
    struct ComplianceModel: HandyJSON {
        //标题
        var title = ""
        //内容
        var content = ""
        //完整图片访问路径
        var iconUrl = ""
    }
    
    /// 实物黄金数据模型
    struct RealGoldModel: HandyJSON {
        var modelId = ""
        //图片链接
        var imageUrl = ""
        //跳转链接
        var linkUrl = ""
    }
    
    /// 首页功能模块数据源
    var sections: [SectionModel] = []
    
    /// 快捷入口区数据源
    var quickEntries: [QuickEntryModel] = []
    
    /// 公告数据源
    var noticeList: [NoticeModel] = []
    
    /// 合规声明数据源
    var copywritingList: [ComplianceModel] = []
    
    /// 实物黄金数据源
    var linkInfoList = [RealGoldModel]()
    
    mutating func mapping(mapper: HelpingMapper) {
        mapper <<< sections     <-- "moduleList"
        mapper <<< quickEntries <-- "quickAreaList"
    }

    
}
