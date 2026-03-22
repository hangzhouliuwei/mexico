//
//  PersonInfoVC.swift
//  LoanPlus
//
//  Created by hao on 2024/12/3.
//

import UIKit
import IQKeyboardManagerSwift

class PersonInfoVC: CertBaseVC {
    var itemList = [JSON]()
    let content = UIScrollView()
    override func viewDidLoad() {
        super.viewDidLoad()
        requestData()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        content.frame = CGRect(x: 15, y: 0, width: ScreenWidth - 30, height: contentView.height - 15)
        content.cornerRadius = 15
        content.backgroundColor = .white
        content.showsVerticalScrollIndicator = false
        contentView.addSubview(content)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        IQKeyboardManager.shared.keyboardDistanceFromTextField = 120
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        IQKeyboardManager.shared.keyboardDistanceFromTextField = 10
    }
    
    func refreshUI() {
        for (i, item) in itemList.enumerated() {
            let itemView = InfoItemView(x: 15, y: 8 + i*90, width: content.width - 30, height: 90)
            itemView.tag = i
            itemView.config(info: item)
            content.addSubview(itemView)
            itemView.changeBlock = { [weak self] info in
                self?.selectAction(value: info, index: i)
            }
        }
        content.contentSize = CGSize(width: content.width, height:itemList.count*90 + 206)
    }
    
    func selectAction(value:JSON, index:Int) {
        var tmp = self.itemList
        tmp[index] = value
        self.itemList = tmp
    }
    
    func requestData() {
        content.frame = CGRect(x: 15, y: 0, width: ScreenWidth - 30, height: contentView.height - 15)
        content.cornerRadius = 15
        content.backgroundColor = .white
        contentView.addSubview(content)
        let dic = [
            "yPIpfzncLDuktqTgNlFIuOLsjr":productId,
            "weFhdKNVhVVAAczmVVwiHW": UserM.phone,
            "iYmBzsfyJDwnhNJm":"215",
        ]
        Network.post(path: .personalGet, parameters: dic, loading: true) { [weak self] res, error in
            if res.success {
                self?.itemList = res.data["JamHxgHiTYxClKqWjuvfkXlPLn"].arrayValue
                self?.refreshUI()
            }
        }
    }
    
    override func nextClick() {
        var dic = ["yPIpfzncLDuktqTgNlFIuOLsjr":productId, "uQQQAbREsstRmKxIQ":"598"]
        for data in itemList {
            let optional = data["byjiVgLBGZQgGFGvNPbnlKFpmdGm"].intValue
            let code = data["yHduRxzXeDDhxXBcvAqiebBdHaYaM"].stringValue
            let value = data["DtdjYPPNFBqrfkqM"].stringValue
            if optional == 0 && value.isEmpty {
                Toast.show(content: "Por favor, complete la verificación")
                return
            }
            if !value.isEmpty {
                dic[code] = value
            }
        }
        Network.post(path: .personalSave, parameters: dic, loading: true) {[weak self] res, error in
            if res.success {
                self?.riskInfo("7")
                let next = res.data["naWCFDhRLBJqBrBQfaZWSolBwWXLf"]["aYpunaUVRMtpaveiMxSZ"].stringValue
                Applyed.nextStep(step: next)
            }
        }
    }
}
