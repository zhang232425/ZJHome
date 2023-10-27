//
//  NSNumber+Extension.swift
//  ZJHome
//
//  Created by Jercan on 2023/10/23.
//

import SwiftDate
import ZJCommonDefines

extension NSNumber {
    
    /// 金额字符
    var currencyDescription: String {
        
        let scale = 0
        
        let formatter = NumberFormatter().then {
            $0.groupingSize = 3
            $0.numberStyle = .currency
            $0.currencySymbol = ZJCountry.currencyCode + " "
            $0.roundingMode = .down
            $0.decimalSeparator = "."
            $0.currencyDecimalSeparator = "."
            $0.minimumFractionDigits = scale
            $0.maximumFractionDigits = scale
            $0.locale = Locales.indonesianIndonesia.toLocale()
        }
        
        return formatter.string(from: self) ?? "0"
        
    }
    
}
