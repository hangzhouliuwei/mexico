//
//  RuteManager.swift
//  LoanPlus
//
//  Created by hao on 2024/11/25.
//


import UIKit
import IQKeyboardManagerSwift

let Page = RuteManager.shared

class RuteManager:NSObject {
    var navigationVC:NavController?
    var tabbarVC:TabBarController?

    static let shared = RuteManager()
    
    func configWindow(window:UIWindow?) {
        tabbarVC = TabBarController()
        navigationVC = NavController(rootViewController:tabbarVC!)
        window?.rootViewController = navigationVC
        navigationVC!.isNavigationBarHidden = true;
        DispatchQueue.main.async {
            IQKeyboardManager.shared.enable = true
            IQKeyboardManager.shared.enableAutoToolbar = false
            IQKeyboardManager.shared.resignOnTouchOutside = true
        }
    }

    func setTitle(title:String){
        tabbarVC?.title = title
    }
    
    func showHomeScreen() {
        tabbarVC?.selectedIndex = 0
        navigationVC?.popToRootViewController(animated: false)
    }
    
   
    func push(vc:UIViewController, animated:Bool = true,hide:Bool = false) {
        navigationVC?.pushViewController(vc, animated: animated)
        if let count = navigationVC?.viewControllers.count, count > 2,hide{
            navigationVC?.viewControllers.remove(at: count - 2)
        }
    }
    
    func pop(animated:Bool) {
        if navigationVC?.viewControllers.count == 0 {
            return
        }
        navigationVC?.popViewController(animated: animated)
    }
    
    func topVC() ->UIViewController? {
        return navigationVC?.topViewController
    }
    
    func switchTabBar(index:Int){
        tabbarVC?.selectedIndex = index
        showHomeScreen()
    }
    
    func present(vc:UIViewController, animated:Bool) {
        topVC()?.present(vc, animated: animated)
    }
    
}
