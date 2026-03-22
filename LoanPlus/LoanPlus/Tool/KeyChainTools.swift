//
//  KeyChainTools.swift
//  LoanPlus
//
//  Created by 刘巍 on 2024/11/25.
//

import UIKit
import Security

let iden_key = "iden_key"


class KeyChainTools {
    
    static func saveKeyChain(value:String ,withKey key:String){
        let data = value.data(using: .utf8)!
        
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key,
            kSecValueData as String: data,
        ]
        
        let status = SecItemAdd(query as CFDictionary, nil)
        if status == errSecSuccess {
            print("-- Log -- Keychain save success (\(key):\(value))")
        }else{
            print("-- Log -- Keychain failed to save (\(key):\(value))")
            
            let attributes: [String: Any] = [
                kSecValueData as String: data
            ]
            let status = SecItemUpdate(query as CFDictionary, attributes as CFDictionary)
            if status == errSecSuccess {
                print("-- Log -- Keychain update success (\(key):\(value))")
            }else{
                print("-- Log -- Keychain failed to update (\(key):\(value))")
            }
        }
    }
    
    static func getChainKey(key:String) ->String?{
        let getQuery: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key,
            kSecReturnData as String: kCFBooleanTrue!,
            kSecMatchLimit as String: kSecMatchLimitOne,
        ]
        
        var dataTypeRef: AnyObject?
        let status2 = SecItemCopyMatching(getQuery as CFDictionary, &dataTypeRef)
        if status2 == errSecSuccess {
            let retrievedData = dataTypeRef as! Data
            let retrievedValue = String(data: retrievedData, encoding: .utf8)
            
            return retrievedValue
        }
        
        return nil
    }
    

}
