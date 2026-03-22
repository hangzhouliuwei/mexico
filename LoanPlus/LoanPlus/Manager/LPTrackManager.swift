//
//  LPTrackManager.swift
//  LoanPlus
//
//  Created by 刘巍 on 2024/11/25.
//

import UIKit
import AppTrackingTransparency
import AdSupport

let AppTrack = LPTrackManager.shared
class LPTrackManager: NSObject {
    
     static let shared = LPTrackManager()
     var idfaID:String = ""
    
     
    func reqAttrack()  {
        if #available(iOS 14, *) {
            Task {
            let _ = await awaitTrackings.requestTrackingAuthorization()
                self.upAttrack()
            }
        }else{
            self.upAttrack()
        }
    }
    
    func upAttrack(){
        idfaID = ASIdentifierManager.shared().advertisingIdentifier.uuidString
        let dic = ["sowjFixDjStchksidW": DeviceManager.getIDFV(), "XuZBByvuxoIeMql": idfaID]
        Network.post(path: .updatamarket, parameters: dic,loading: false) { res, error in
            if res.success{
                
            }
        }
    }
    
    
    final class awaitTrackings {
        @available(iOS 14, *)
        class func requestTrackingAuthorization() async -> ATTrackingManager.AuthorizationStatus {
            let status = await ATTrackingManager.requestTrackingAuthorization()
            if status == .denied, ATTrackingManager.trackingAuthorizationStatus == .notDetermined {
                debugPrint("iOS 17.4 ATT bug detected")
                if #available(iOS 15, *) {
                    for await _ in await NotificationCenter.default.notifications(named: UIApplication.didBecomeActiveNotification) {
                        return await requestTrackingAuthorization()
                    }
                } else {
                    return status
                }
            }

            return status
        }
    }
    
    func riskInfo(_ type:String, _ time:String, _ productId:String) {
        
        let info = ["puxusqriYPrFEZNmLglkJt":type,
                    "OJpytjtHkpYbFOzfVCRyRgjFnRN":productId,
                    "IaEOBEaqjAElxDuHgPYyQSPTRT": DeviceManager.getIDFV(),
                    "uWWsWqAEznLwpCk": Localed.longFloat,
                    "GVqqUZUXuJTgROSUwUTRnsaD": Localed.latiFloat,
                    "skNyksvOPUjaYExUKjbUKFuWzsd": time,
                    "RJSRvmPZAcEeXMP": time == "0" ? "0" : String.nowTimeString(),
                    "OpbmqDDvNCcuBkRloW": 564411
        ] as [String : Any]
        
        Network.post(path: .riskInfo, parameters: info) { res, error in
            
        }
    }
    
    func deviceInfo() {
        let info = DeviceManager.shared.getDeviceData()
        Network.post(path: .deviceInfo, parameters: info) { res, error in

        }
    }
}
