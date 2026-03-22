//
//  AppDelegate.swift
//  LoanPlus
//
//  Created by hao on 2024/11/25.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    static var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        createWindow()
        return true
    }
    
    func createWindow() {
        AppDelegate.window = UIWindow(frame: UIScreen.main.bounds)
        AppDelegate.window?.backgroundColor = UIColor.white
        AppDelegate.window?.makeKeyAndVisible()
        Page.configWindow(window:AppDelegate.window)
    }
}

