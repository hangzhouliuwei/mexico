//
//  CacheManager.swift
//  LoanPlus
//
//  Created by hao on 2024/11/25.
//


class CacheManager {
    static func setString(value:String, key:String) {
        UserDefaults.standard.set(value, forKey: key)
        UserDefaults.standard.synchronize()
    }
    
    static func stringValueForKey(key:String) -> String {
        UserDefaults.standard.string(forKey: key) ?? ""
    }
}
