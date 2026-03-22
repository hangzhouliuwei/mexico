//
//  HomeVC.swift
//  LoanPlus
//
//  Created by hao on 2024/11/25.
//

import UIKit
import SnapKit
import MJRefresh
import Foundation


class HomeVC: BaseVC {
    
    let homeLargeView = HomeLargeCardView()
    let homeLoanMorePlusView = HomeLoanMorePlusView()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        
        contentView.addSubview(homeLargeView);
        
        
        homeLargeView.snp.remakeConstraints { make in
            make.top.left.equalToSuperview()
            make.width.equalTo(ScreenWidth)
            make.height.equalTo(830)
        }
        contentView.addSubview(homeLoanMorePlusView);
        homeLoanMorePlusView.snp.makeConstraints { make in
            make.top.left.equalToSuperview()
            make.width.equalTo(ScreenWidth)
            make.height.equalTo(830);
        }
        
        homeLoanMorePlusView.isHidden = true
        
        setupRefreshControl()
        contentView.fitView(view: homeLoanMorePlusView)

        
        NotificationCenter.default.addObserver(self, selector: #selector(loadConfigData), name: home_update, object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadConfigData()
    }
    
    @objc func loadConfigData(){
        Network.get(path: .homeData) { [self] res, error in
            self.contentView.mj_header?.endRefreshing() // 结束刷新
            let homeDataArray = res.data["JucvBgeXWOYVjsOsUU"].arrayValue
            var islargehome = false;
            var productArray:[ JSON ]?
            for homeItem in homeDataArray {
                if homeItem["MxpNpYKadDRvmjqybUjsIEARDwIwW"]  == "CASHRAP_TWO" {
                    islargehome = true;
                }
                
                
                if homeItem["MxpNpYKadDRvmjqybUjsIEARDwIwW"]  == "CASHRAP_FOUR" {
                    
                    let product_quick_Array = homeItem["AKDaQpLIziPsAlUT"].arrayValue;
                    productArray = product_quick_Array
                }
            }
            homeLargeView.isHidden = !islargehome;
            homeLoanMorePlusView.isHidden = islargehome;
            if islargehome {
                homeLargeView.loadTheSubViewWithData(data: res.data)
                homeLargeView.snp.remakeConstraints { make in
                    make.top.left.equalToSuperview()
                    make.width.equalTo(ScreenWidth)
                    make.height.equalTo(830)
                }
                contentView.fitView(view: homeLargeView)


            }else {
                homeLoanMorePlusView.loadTheSubViewWithData(data: res.data)
                homeLoanMorePlusView.snp.remakeConstraints { make in
                    make.top.left.equalToSuperview()
                    make.width.equalTo(ScreenWidth)
                    make.height.equalTo(320 + 160 * ((productArray?.count ?? 0)+1))
                }
                contentView.fitView(view: homeLoanMorePlusView)

            }
            
            Applyed.homeTime = String.nowTimeString()
        }
    }
    
    func setupRefreshControl() {
        contentView.mj_header = MJRefreshNormalHeader(refreshingTarget: self, refreshingAction: #selector(refreshData))
    }
    
    override func contentVeiwHeight() -> Double {
        return ScreenHeight
    }
    
    @objc func refreshData() {
        DispatchQueue.main.asyncAfter(deadline: .now()) {
            self.loadConfigData()
        }
    }
    
}

