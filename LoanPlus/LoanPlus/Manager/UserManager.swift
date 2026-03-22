//
//  UserManager.swift
//  LoanPlus
//
//  Created by 刘巍 on 2024/11/25.
//

import UIKit

let UserM = UserManager.shared

class UserManager: NSObject {
    
    static let shared = UserManager()

    func isLogin() ->Bool{
        if isStingCheck(sessionId){
            login()
            return false
        }
        return true
    }
    
    func login() {
        logouted()
        let loginVC = LoginVC()
        let nav = NavController(rootViewController: loginVC)
        nav.modalPresentationStyle = .fullScreen
        Page.present(vc: nav, animated: true)

    }
    
    func logouted(){
        self.phone = ""
        self.sessionId = ""
    }
    
    var sessionId: String {
        
        get{
            let str =  UserDefaults.standard.string(forKey: "sessionId") ?? ""
            return str
        }
        set{
            UserDefaults.standard.set(newValue, forKey: "sessionId")
        }
    }
    
    var phone:String{
        get{
            let str = UserDefaults.standard.string(forKey: "phone") ?? ""
            return str
        }
        set{
            UserDefaults.standard.set(newValue, forKey: "phone")
        }
        
    }

}
