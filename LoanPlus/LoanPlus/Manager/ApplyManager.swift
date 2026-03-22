//
//  ApplyManager.swift
//  LoanPlus
//
//  Created by Kiven on 2024/11/25.
//

import UIKit

let Applyed = ApplyManager.shared

enum CertType: String {
    case credit = "credit"
    case pub = "public"
    case personal = "personal"
    case job = "job"
    case ext = "ext"
    case bank = "bank"
    
    init?(from string: String) {
        switch string {
        case "credit":
            self = .credit
        case "public":
            self = .pub
        case "personal":
            self = .personal
        case "job":
            self = .job
        case "ext":
            self = .ext
        case "bank":
            self = .bank
        default:
            return nil
        }
    }
}

class ApplyManager{
    
    static let shared = ApplyManager()
    
    var productId:String = ""
    var amount:String = ""
    var homeTime = ""
    func applyNow(id:String){
        self.productId = id
        checkLocation()
    }
    
    func checkLocation () {
        Localed.getLocationInfo { [weak self] success, res in
            if success {
                self?.uploadLocaton(res)
            }else {
                self?.showLocationAlert()
            }
        }
    }
    
    func showLocationAlert() {
        let alert = UIAlertController(title: nil, message: "No se pudo obtener permiso de ubicación", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Abrir configuración", style: .default, handler: { _ in
            if let settingsUrl = URL(string: UIApplication.openSettingsURLString) {
                UIApplication.shared.open(settingsUrl, options: [:], completionHandler: nil)
            }
        }))
        alert.addAction(UIAlertAction(title: "Cancelar", style: .cancel, handler: nil))

        Page.present(vc: alert, animated: true)
    }
    
    func uploadLocaton(_ res: [String:Any]?) {
        Network.post(path: .locationInfo, parameters: res, loading: true) { [weak self] res, error in
            if res.success {
                self?.apply()
            }
        }
        AppTrack.riskInfo("1", homeTime, productId)
    }
    
    func apply() {
        Network.post(path: .productApply,parameters: ["KVtMbJfcuaAtUVDpXyEISeRnFdn":"1001","XJYkraZaIzXLlXdjyQ":"1000","yPIpfzncLDuktqTgNlFIuOLsjr":self.productId],loading: true) { res, error in
            if res.success {
                let path = res.data["QMhNOYRoRAAQmsLJAMkjm"].stringValue
                self.jumpCheck(path: path)
            }
        }
        AppTrack.deviceInfo()
    }
    
    func jumpCheck(path:String,hide:Bool = false){
        print("-- Log -- jump:\(path)")
        if path.hasPrefix("http"){
            
        let proweb =  ProWebViewController()
            proweb.url = path
            Page.push(vc: proweb,hide: hide)
            
        }else
            if path.contains("XliUCrCdjdGhNn"){//main
                Page.showHomeScreen()
            
            }else if path.contains("KmzMyggZcnHDwm"){//setting
                let setVC = SettingVC()
                Page.push(vc: setVC)
                
            }else if path.contains("eJjBPIRIMYosXgK"){//login
                UserM.login()
                
            }else if path.contains("SGarpJxVEsZldT"){//order
                let orderVC = LoanPlusOrderVC()
                Page.push(vc: orderVC)
                
            }else if path.contains("DzNjUygNxMLZSMn"){ //productDetail
                let file = ProductDetailVC()
                if let url = URL(string: path) {
                    if let components = URLComponents(url: url, resolvingAgainstBaseURL: false) {
                        if let queryItems = components.queryItems {
                            for item in queryItems {
                                if item.name == "yPIpfzncLDuktqTgNlFIuOLsjr",let value = item.value{
                                    file.pro_id = value
                                }
                            }
                        }
                    }
                }
                Page.push(vc: file, animated: true)
            
        }else{
            nextStep(step: path)
        }
        
    }
    
    func nextStep(step:String,proId:String?=nil,isDone:Bool = false){
        print("-- Log -- go next step:\(step)")
        if let proId = proId{
            self.productId = proId
        }
        if let nextStep = CertType(from: step){
            
            switch nextStep {
            case .credit:
                let vc = SurveyVC(certType: nextStep)
                vc.productId = productId
                vc.isDone = isDone
                Page.push(vc: vc, animated: true)
                
            case .pub:
                let vc = IDCardVC(certType: nextStep)
                vc.productId = productId
                vc.isDone = isDone
                Page.push(vc: vc, animated: true)
                
            case .personal:
                let vc = PersonInfoVC(certType: nextStep)
                vc.productId = productId
                vc.isDone = isDone
                Page.push(vc: vc, animated: true)
                
            case .job:
                let vc = JobInfoVC(certType: nextStep)
                vc.productId = productId
                vc.isDone = isDone
                Page.push(vc: vc, animated: true)
                
            case .ext:
                let vc = ContactInfoVC(certType: nextStep)
                vc.productId = productId
                vc.isDone = isDone
                Page.push(vc: vc, animated: true)
                
            case .bank:
                let vc = BankInfoVC(certType: nextStep)
                vc.productId = productId
                vc.isDone = isDone
                Page.push(vc: vc, animated: true)
                
            }
            
        }else{
            print("k-- step nil popVC")
            Page.pop(animated: true)
        }
        
    }
    
    func productPush(amount:String,orderNo:String){
        print("k-- productPush")
        AppTrack.riskInfo("11", "0", productId)
        Network.post(path: .productPush,parameters: ["mJrNNSTbIbzTlGvlvjVrHExnYb":amount,"slSRNShwQQeMAHekcEoqxSQznL":orderNo],loading: true) { res, error in
            let path = res.data["QMhNOYRoRAAQmsLJAMkjm"].stringValue
            self.jumpCheck(path: path,hide: true)
        }
        
        
    }
    
    
}
