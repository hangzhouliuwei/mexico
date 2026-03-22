//
//  Define.swift
//  LoanPlus
//
//  Created by hao on 2024/11/25.
//

import Foundation
import UIKit

let ScreenWidth             =   UIScreen.main.bounds.size.width
let ScreenHeight            =   UIScreen.main.bounds.size.height
let StatusBarHeight         =   (AppDelegate.window?.windowScene?.statusBarManager?.statusBarFrame.size.height)!
let NavBarHeight            =   (44.0 + StatusBarHeight)
let TabBarHeight            =   (StatusBarHeight > 20.0 ? 119.0 : 85.0)
let SafeBottomHeight        =   (StatusBarHeight > 20.0 ? 34.0 : 0.0)
let LeftMargin              =   16.0.w
let SafeWidth               =   ScreenWidth - 2*LeftMargin
let KScale                  =   (ScreenWidth/375.0)

func isStingCheck(_ string: String?) -> Bool {
    if string == nil {
        return true
    }
    if string!.isEmpty {
        return true
    }
    return false
}

let home_update = NSNotification.Name("home_update")

typealias VoidBlock = () -> Void
typealias IntBlock = (_ result: Int) -> Void
typealias StringBlock = (_ result: String) -> Void
typealias BoolBlock = (_ result: Bool) -> Void
typealias AnyBlock = (_ result: Any) -> Void
typealias UrlBlock = (_ result: URL) -> Void
typealias ArrayBlock = (_ result: [Any]) -> Void
typealias DicBlock = (_ result: Dictionary<String, Any>) -> Void
typealias JsonBlock = (_ result: JSON) -> Void
typealias Dic = Dictionary<String, Any>
typealias Arr = Array<Any>
