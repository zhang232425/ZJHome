//
//  P2PProductModel.swift
//  ZJHome
//
//  Created by Jercan on 2023/10/20.
//

import HandyJSON

class P2PProductModel: HandyJSON {
    
    enum Period: Int, HandyJSONEnum {
        case day   = 1
        case month = 2
    }
    
    enum Status: Int, HandyJSONEnum {
        case unknown       = -1
        case pendingSale   = 310
        case isSelling     = 510
        case soldOut       = 610
        // 下架
        case unavailable   = 999
    }
    
    // 产品ID
    var id = ""
    
    // 产品名称
    var name = ""
    
    // 周期数值
    var period = 0
    
    var periodUnit = Period.day
    
    // 回报率
    var rate = Double(0)
    
    // 加息
    var raiseInterestRate = Double(0)
    
    var status = Status.unknown
    
    var productType = P2PProductType.unknown
    
    var productCategory: P2PProductCategory?
    
    // 标签文字
    var label = ""
    
    // 是否可用优惠券
    var canUseCoupon = false
    
    // 投资人数
    var funderCount = 0
    
    // 起投金额
    var baseAmount = NSNumber(value: 0)
    
    // 是否展示额度
    var isShowAmount = false
    
    // 产品总额度
    var total = NSNumber(value: 0)
    
    // 产品投资进度
    var usePercent = Double(0)
    
    // 剩余额度
    var remain = NSNumber(value: 0)
    
    // 卖点列表
    var salePointList = [String]()
    
    // 售罄文案
    var soldOutTips = ""
    
    required init() {}
    
    func mapping(mapper: HelpingMapper) {
        mapper <<< canUseCoupon <-- "ableCoupon"
        mapper <<< funderCount <-- "fundCount"
    }
    
    
}

import ZJLocalizable

extension P2PProductModel {
    
    var progress: CGFloat {
        if usePercent > 1.0 {
            return 1.0
        }
        return CGFloat(usePercent)
    }
    
    var remainDescription: String {
        if status == .soldOut {
            return soldOutTips
        }
        let prefix = Locale.productCellRemainPrefix.localized + " "
        return prefix + remain.currencyDescription
    }
    
    var periodDescription: String {
        let unit: String
        let suffix = (period > 1 && ZJLocalizer.currentLanguage == .en) ? "s" : ""
        switch periodUnit {
        case .day:
            unit = Locale.productPeriodUnitDay.localized
        case .month:
            unit = Locale.productPeriodUnitMonth.localized
        }
        return "\(period)" + " " + unit + suffix
    }
    
}
