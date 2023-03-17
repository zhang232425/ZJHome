//
//  TKBInfoCache.swift
//  Action
//
//  Created by Jercan on 2023/2/21.
//

import ZJRequest
import HandyJSON

struct TKBInfoCache {
    
    static func getTKBText(completion: @escaping (String) -> Void) {
        
        if let tkbInfo = UserDefaults.standard.tkbInfoCache,
            Date().timeIntervalSince1970 - tkbInfo.updateTime <= (10 * 60) { // 10min以内，直接用缓存
            completion(tkbInfo.text)
        } else {
            HomeAPI.ktbInfo.requestObject(success: { (m: ZJRequestResult<String>) in
                let text = m.data ?? ""
                completion(text)
                UserDefaults.standard.tkbInfoCache = .init(updateTime: Date().timeIntervalSince1970, text: text)
            }, failure: { _ in
                completion("")
            })
        }
        
    }
    
}

fileprivate struct TKBInfo: HandyJSON {

    var updateTime = TimeInterval(0)

    var text = ""

}

private extension UserDefaults {

    var tkbInfoCache: TKBInfo? {
        get {
            let data = UserDefaults.standard.data(forKey: #function) ?? .init()
            let dict = (try? JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed)) as? [String: Any]
            return TKBInfo.deserialize(from: dict)
        }
        set {
            if let json = newValue?.toJSON(), let data = try? JSONSerialization.data(withJSONObject: json, options: .prettyPrinted) {
                UserDefaults.standard.setValue(data, forKey: #function)
            } else {
                UserDefaults.standard.setValue(nil, forKey: #function)
            }
            UserDefaults.standard.synchronize()
        }
    }

}

