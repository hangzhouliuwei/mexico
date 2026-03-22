//
//  NetworkManager.swift
//  LoanPlus
//
//  Created by hao on 2024/11/25.
//

import UIKit
import Alamofire

let Network = NetworkManager.shared
//#if DEBUG
let baseUrl = "http://api-super_ios8.mx.test.ksmdev.top"
//#else
//let baseUrl = "https://api.vales-defelicidad.com"
//#endif


let PrivacyPath = baseUrl+"/#/privacyAgreement"
let LoanPath = baseUrl+"/#/loanAgreement"

enum RequestPath:String {

    case homeData = "/ABMpviHMvnzZGG"
    case orderTypeList = "/bWOaTOXkxvoa"
    case updatamarket = "/QiDlCfckMPYbDa"
    
    case getCode = "/kjTXgaipNFTKcL"
    case login = "/KvlMxqTcPk"
    case loginOut = "/GNoGNjVeiVNZZ"
    
    case riskInfo = "/ENfvumPoishPER"
    case locationInfo = "/jQEruvSVYspMJA"
    case deviceInfo = "/NymfYuXRUsyflk"
    case productApply = "/eKvMelTIKoDMssl"
    case productDetail = "/pxKAVMTCTbSCbnq"
    case productPush = "/egLyvflRvdG"
    
    case surveyGet = "/QgCDHGQbVjIko"
    case surveySave = "/LIlMoDpoiDyM"
    
    case publicGet = "/XwGMXUwJeaR"
    case uploadImg = "/zcEdzKnKrJyX"
    case getLicense = "/vtwcksblZaRlQ"
    case publicSave = "/kcPFMDtTTpvEWo"
    
    case personalGet = "/FMJAiJQlFvavesD"
    case personalSave = "/pNbvKTftewl"
    
    case jobGet = "/KhtLRFJGYLTlnmZ"
    case jobSave = "/rlGmvtiRyXGInfC"
    
    case extGet = "/yLknlzKUHeeiQU"
    case extSave = "/gxvtJafNQPuFCK"
    
    case bankGet = "/qxTFAkdZbWVRe"
    case bankSave = "/TkFZjVXVAzT"
    
    case userCenter = "/xliJiOYyqwEo"


}

class NetworkManager {
    
    static let shared = NetworkManager()
    
    var header:HTTPHeaders = ["Content-Type":"application/json","Accept":"application/json"]
    
    let netReacher = NetworkReachabilityManager()
    var networkStatus = ""
    
    private init() {
        getNetworkStatus()
    }
    
    func addHeaderParameters(pathStr:String) ->String{
        let params:[String:Any] = ["fAYUxpHUnjmBwGmcdSczaFrZtuZP":"ios",
                                   "uMEMEcDsjXLLlQPy": DeviceManager.getAppVersion(),
                                   "FxpSSsAwRFoegtSoUEPg":DeviceManager.getModelName(),
                                   "KFfcABnExHRByLTZpetw":DeviceManager.getIDFV(),
                                   "vjuoBzixWZVyDOTHmj":DeviceManager.getSystemVersion(),
                                   "rcznbeRnHTsKnaMMe":"superp-sp",
                                   "rBsPRLsGdjGWMXZ": UserM.sessionId,//SessionId
                                   "qXKkufSJISMUrtLHMqKcQrYmBePHz":AppTrack.idfaID,
                                   "mobilePhone":UserM.phone,//phone number
                                   "dqRTAcPsXwobSxnoX":"super_ios8",
                                   "packageId":DeviceManager.getAppBundleId(),
                                   "merchantName":"ios"
                                  ]
        let keyArray = params.keys
        let sortedArray = keyArray.sorted { $0.compare($1, options: .numeric) == .orderedAscending }
        
        var valueArray = [Any]()
        for sortString in sortedArray {
            if let value = params[sortString] {
                valueArray.append(value)
            }
        }
        
        var signArray = [String]()
        for (index, key) in sortedArray.enumerated() {
            var keyValueStr: String
            let value = valueArray[index]
            
            if let arrayValue = value as? [Any], let json = objcToJSONString(arrayValue) {
                keyValueStr = "\(key)=\(json)"
            } else if let dictValue = value as? [String: Any], let json = objcToJSONString(dictValue) {
                keyValueStr = "\(key)=\(json)"
            } else {
                keyValueStr = "\(key)=\(value)"
            }
            
            signArray.append(keyValueStr)
        }
        
        let signString = signArray.joined(separator: "&")
        return baseUrl+"/api"+pathStr+"?"+(signString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")
    }
    
    public func get(path:RequestPath, parameters:[String:Any]? = nil, loading:Bool = false, callback: @escaping (_ res: AFResponse, _ error: Error?) -> Void) {
        if loading {
            Loading.show()
        }
        let url = addHeaderParameters(pathStr: path.rawValue)
        print("请求的url:   "+(url))
        AF.request(url, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: header).response { (response) in
            if loading {
                Loading.hide()
            }
            switch response.result {
            case .success(_):
                if let data = response.data {
                    let json = JSON(data)
                    print("+++++++ \n \(url) \n\n \(parameters) \n\n \(json.dictionaryObject) \n ------- \n\n")
                    let result = AFResponse()
                    result.code = json["yHduRxzXeDDhxXBcvAqiebBdHaYaM"].intValue
                    result.success = result.code == 0
                    result.msg = json["sULmmkIBKPDlleIxDFJcNLy"].stringValue
                    result.path = path.rawValue
                    result.data = json["gbDLHfZgaiKTPPaRo"]
                    if (result.code == -2) {
                        Toast.show(content: result.msg)
                        UserM.login()
                    }else {
                        callback(result, nil)
                    }
                }
            case .failure(let error):
                callback(AFResponse(), error)
            }
        }
    }
    
    public func post(path:RequestPath, parameters:[String:Any]? = nil, loading:Bool = false, callback: @escaping (_ res: AFResponse, _ error: Error?) -> Void) {
        if loading {
            Loading.show()
        }
        let url = addHeaderParameters(pathStr: path.rawValue)
        AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: header).response { (response) in
            if loading {
                Loading.hide()
            }
            switch response.result {
            case .success(_):
                if let data = response.data {
                    let json = JSON(data)
                    print("+++++++ \n \(url) \n\n \(parameters) \n\n \(json.dictionaryObject) \n ------- \n\n")
                    let result = AFResponse()
                    result.code = json["yHduRxzXeDDhxXBcvAqiebBdHaYaM"].intValue
                    result.success = result.code == 0
                    result.msg = json["sULmmkIBKPDlleIxDFJcNLy"].stringValue
                    result.path = path.rawValue
                    result.data = json["gbDLHfZgaiKTPPaRo"]
                    if !result.success,loading{
                        Toast.show(content: result.msg)
                    }
                    if (result.code == -2) {
                        UserM.login()
                    }else {
                        callback(result, nil)
                    }
                }
            case .failure(let error):
                callback(AFResponse(), error)
            }
        }
    }
    
    func upload(path: RequestPath, params: [String: Any]?, image: UIImage, callback: @escaping (_ res: AFResponse, _ error: Error?) -> Void) {
        Loading.show()
        let url = addHeaderParameters(pathStr: path.rawValue)
        guard let data = image.jpegData(compressionQuality: 0.5) else {
            print("Failed to compress image")
            Loading.hide()
            return
        }
        AF.upload(
            multipartFormData: { formData in
                formData.append(data, withName: "oebtDinYxGHKWFhzmnWx", fileName: "imageFile.jpg", mimeType: "image/jpeg")
                if let par = params {
                    for (key, value) in par {
                        if let valueData = "\(value)".data(using: .utf8) {
                            formData.append(valueData, withName: key)
                        }
                    }
                }
            },
            to: url,
            method: .post,
            headers: header
        )
        .validate()
        .response { response in
            Loading.hide()
            switch response.result {
            case .success(_):
                if let data = response.data {
                    let json = JSON(data)
                    print("+++++++ \n \(url) \n\n \(String(describing: json.dictionaryObject)) \n -------")
                    let result = AFResponse()
                    result.code = json["yHduRxzXeDDhxXBcvAqiebBdHaYaM"].intValue
                    result.success = result.code == 0
                    result.msg = json["sULmmkIBKPDlleIxDFJcNLy"].stringValue
                    result.path = path.rawValue
                    result.data = json["gbDLHfZgaiKTPPaRo"]
                    callback(result, nil)
                }
            case .failure(let error):
                callback(AFResponse(), error)
            }
        }
    }
    
    func getNetworkStatus() {
        netReacher?.startListening(onUpdatePerforming: { status in
            switch status {
            case .notReachable:
                self.networkStatus = ""
            case .unknown:
                self.networkStatus = "Unkonwn"
            case .reachable(.ethernetOrWiFi):
                self.networkStatus = "wifi"
                NotificationCenter.default.post(name: home_update, object: nil)
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    AppTrack.reqAttrack()
                }
            case .reachable(.cellular):
                self.networkStatus = "4g"
                NotificationCenter.default.post(name: home_update, object: nil)
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    AppTrack.reqAttrack()
                }
            }
        })
    }
    
    func objcToJSONString(_ object: Any) -> String? {
        guard let jsonData = try? JSONSerialization.data(withJSONObject: object, options: []) else {
            return nil
        }
        return String(data: jsonData, encoding: .utf8)
        
    }
}

class AFResponse {
    var success = false
    var code:Int?
    var msg = ""
    var path = ""
    var data = JSON()
}
