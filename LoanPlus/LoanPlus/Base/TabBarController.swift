//
//  TabBarController.swift
//  LoanPlus
//
//  Created by hao on 2024/11/25.
//


import UIKit

class TabBarController: UITabBarController,UITabBarControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        setTaBbar()
        
//        let main = HomeVC()
//        main.navBarHidden = true
//        let user = UserVC()
//        user.navBarHidden = true
//        self.viewControllers = [main, user]
//        let titles = ["Inicio", "Perfil"]
//        let icons = ["home", "mine"]
//        let iconsSelected = ["home_s", "mine_s"]
//        
//        for i in 0..<titles.count {
//            let barItem:UITabBarItem? = tabBar.items?[i]
//            barItem?.title = titles[i]
//            barItem?.image = UIImage(named:icons[i])
//            barItem?.selectedImage = UIImage(named: iconsSelected[i])?.withRenderingMode(.alwaysOriginal)
//            barItem?.setTitleTextAttributes([NSAttributedString.Key.foregroundColor : UIColor.textBlack], for: .normal)
//            barItem?.setTitleTextAttributes([NSAttributedString.Key.foregroundColor : UIColor.main], for: .selected)
//        }
//        self.tabBar.tintColor = .main
//        self.tabBar.barTintColor = .bg
//        self.tabBar.isTranslucent = false
//        UITabBarItem.appearance().titleTextAttributes(for: .normal)
//        self.tabBar.shadowImage = UIImage()
//        self.tabBar.backgroundImage = UIImage()
        
        
        let homeVC = HomeVC()
        homeVC.navBarHidden = true
        //homeVC.view.backgroundColor = .white
        let homeIcon = UIImage(named: "tab_home_Nor")?.withRenderingMode(.alwaysOriginal)
        let homeIconSelected = UIImage(named: "tab_home_Select")?.withRenderingMode(.alwaysOriginal)
        let homeItem = UITabBarItem(title: "Inicio", image: homeIcon, selectedImage: homeIconSelected)
        homeItem.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: -8)
        homeVC.tabBarItem = homeItem
        
        let mineVC = UserVC()
        mineVC.navBarHidden = true
        //mineVC.view.backgroundColor = .white
        let userIcon = UIImage(named: "tab_mine_Nor")?.withRenderingMode(.alwaysOriginal)
        let userIconSelected = UIImage(named: "tab_mine_Select")?.withRenderingMode(.alwaysOriginal)
        let userItem = UITabBarItem(title: "Perfil", image: userIcon, selectedImage: userIconSelected)
        userItem.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: -8)
        mineVC.tabBarItem = userItem

        self.viewControllers = [homeVC, mineVC]
        self.delegate = self
    }
    
    func setTaBbar(){
        let tabBar = self.tabBar
        tabBar.backgroundColor = UIColor.white
        tabBar.layer.cornerRadius = 28
        tabBar.shadowImage = UIImage()
        tabBar.backgroundImage = UIImage()
        tabBar.layer.shadowColor = UIColor.black.cgColor
        tabBar.layer.shadowOpacity = 0.1
        tabBar.layer.shadowOffset = CGSize(width: 0, height: 3)
        tabBar.layer.shadowRadius = 5
        tabBar.isTranslucent = true
        tabBar.tintColor = UIColor(hex: "#080403")
        tabBar.unselectedItemTintColor = UIColor(hex: "#999999")
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let maigin: CGFloat = 80
        var tabFrame = self.tabBar.frame
        tabFrame.size.height = 60
        let saceH = SafeBottomHeight + 60;
        tabFrame.origin.y = self.view.frame.size.height - saceH
        tabFrame.size.width = self.view.frame.size.width - (maigin * 2)
        tabFrame.origin.x = maigin
        self.tabBar.frame = tabFrame
    }
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        if viewController is UserVC {
            return UserM.isLogin()
        }
        return true
    }
}
