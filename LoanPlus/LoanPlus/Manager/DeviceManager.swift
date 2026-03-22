//
//  DeviceManager.swift
//  LoanPlus
//
//  Created by 刘巍 on 2024/11/25.
//

import UIKit
import SystemConfiguration.CaptiveNetwork
import CoreTelephony
import MachO
import Darwin

class DeviceManager: NSObject {
    static let shared = DeviceManager()
    let Device = UIDevice.current
    
    static func getIDFV() -> String{
        if let  idfv = KeyChainTools.getChainKey(key: iden_key),!isStingCheck(idfv){
            return idfv
        }
        
        let idfv =  UIDevice.current.identifierForVendor?.uuidString ?? ""
        KeyChainTools.saveKeyChain(value: idfv, withKey: iden_key)
        
        return idfv
    }
    
    static func getAppVersion() -> String{
        
        return  Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "1.0.0"
    }
    
    
    static func getAppName() -> String{
        
        return Bundle.main.infoDictionary?["CFBundleDisplayName"] as? String ?? ""
    }
    
    static func getAppBundleId() -> String{
        
        return Bundle.main.bundleIdentifier ?? ""
    }
    
    static func getSystemVersion() -> String {
        
        return UIDevice.current.systemVersion
    }
    
    static func getModelName() -> String{
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8 , value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        
        switch identifier {
            
        case "AppleTV2,1":  return "Apple TV 2"
        case "AppleTV3,1","AppleTV3,2":  return "Apple TV 3"
        case "AppleTV5,3":   return "Apple TV 4"
            
        case "iPod1,1":  return "iPod Touch 1"
        case "iPod2,1":  return "iPod Touch 2"
        case "iPod3,1":  return "iPod Touch 3"
        case "iPod4,1":  return "iPod Touch 4"
        case "iPod5,1":  return "iPod Touch 5"
        case "iPod7,1":   return "iPod Touch 6"
        case "iPod9,1":   return "iPod Touch 7"
            
        case "iPad1,1":   return "iPad"
        case "iPad1,2":   return "iPad 3G"
        case "iPad2,1", "iPad2,2", "iPad2,3", "iPad2,4":   return "iPad 2"
        case "iPad2,5", "iPad2,6", "iPad2,7":  return "iPad Mini"
        case "iPad3,1", "iPad3,2", "iPad3,3":  return "iPad 3"
        case "iPad3,4", "iPad3,5", "iPad3,6":   return "iPad 4"
        case "iPad4,1", "iPad4,2", "iPad4,3":   return "iPad Air"
        case "iPad4,4", "iPad4,5", "iPad4,6":  return "iPad Mini 2"
        case "iPad4,7", "iPad4,8", "iPad4,9":  return "iPad Mini 3"
        case "iPad5,1", "iPad5,2":  return "iPad Mini 4"
        case "iPad5,3", "iPad5,4":   return "iPad Air 2"
        case "iPad6,3", "iPad6,4":  return "iPad Pro 9.7"
        case "iPad6,7", "iPad6,8":  return "iPad Pro 12.9"
        case "iPad6,11", "iPad6,12":  return "iPad 5"
        case "iPad7,1", "iPad7,2":  return "iPad Pro 12.9 inch 2nd gen"
        case "iPad7,3", "iPad7,4":  return "iPad Pro 10.5 inch"
        case "iPad7,5", "iPad7,6":  return "iPad 6"
        case "iPad7,11", "iPad7,12":  return "iPad 7"
        case "iPad8,1 ~ 8,4":  return "iPad Pro 11-inch"
        case "iPad8,5 ~ 8,8":  return "iPad Pro 12.9-inch 3rd gen"
        case "iPad8,9 ~ 8,10":  return "iPad Pro 11-inch 2nd gen"
        case "iPad8,11 ~ 8,12":  return "iPad Pro 12.9-inch 4th gen"
        case "iPad11,1", "iPad11,2":  return "iPad Mini 5"
        case "iPad11,3", "iPad11,4":  return "iPad Air 3"
        case "iPad11,6", "iPad11,7":  return "iPad 8"
        case "iPad12,1", "iPad12,2":  return "iPad 9"
        case "iPad13,1", "iPad13,2":  return "iPad Air 4"
        case "iPad14,1", "iPad14,2":  return "iPad Mini 6"
        case "iPad13,4 ~ 13,7":return "iPad Pro 11-inch 3nd gen"
        case "iPad13,8 ~ 13,11":return "iPad Pro 12.9-inch 5th gen"
        case "iPad13,16","iPad13,17":return "iPad Air 5"
        case "iPad13,18","iPad13,19":return "iPad 10"
        case "iPad14,3 ~ 14,4":return "iPad Pro 11-inch 4th gen"
        case "iPad14,5 ~ 14,6":return "iPad Pro 12.9-inch 6th gen"
            
        case "iPhone3,1", "iPhone3,2", "iPhone3,3":  return "iPhone 4"
        case "iPhone4,1":  return "iPhone 4s"
        case "iPhone5,1":   return "iPhone 5"
        case  "iPhone5,2":  return "iPhone 5 (GSM+CDMA)"
        case "iPhone5,3":  return "iPhone 5c (GSM)"
        case "iPhone5,4":  return "iPhone 5c (GSM+CDMA)"
        case "iPhone6,1":  return "iPhone 5s (GSM)"
        case "iPhone6,2":  return "iPhone 5s (GSM+CDMA)"
        case "iPhone7,2":  return "iPhone 6"
        case "iPhone7,1":  return "iPhone 6 Plus"
        case "iPhone8,1":  return "iPhone 6s"
        case "iPhone8,2":  return "iPhone 6s Plus"
        case "iPhone8,4":  return "iPhone SE"
        case "iPhone9,1":   return "iPhone 7"
        case "iPhone9,2":  return "iPhone 7 Plus"
        case "iPhone9,3":  return "iPhone 7"
        case "iPhone9,4":  return "iPhone 7 Plus"
        case "iPhone10,1","iPhone10,4":   return "iPhone 8"
        case "iPhone10,2","iPhone10,5":   return "iPhone 8 Plus"
        case "iPhone10,3","iPhone10,6":   return "iPhone X"
        case "iPhone11,8":  return "iPhone XR"
        case "iPhone11,2":  return "iPhone XS"
        case "iPhone11,6", "iPhone11,4":    return "iPhone XS Max"
        case "iPhone12,1":  return "iPhone 11"
        case "iPhone12,3":  return "iPhone 11 Pro"
        case "iPhone12,5":  return "iPhone 11 Pro Max"
        case "iPhone12,8":  return "iPhone SE2"
        case "iPhone13,1":  return "iPhone 12 mini"
        case "iPhone13,2":  return "iPhone 12"
        case "iPhone13,3":  return "iPhone 12 Pro"
        case "iPhone13,4":  return "iPhone 12 Pro Max"
        case "iPhone14,4":  return "iPhone 13 mini"
        case "iPhone14,5":  return "iPhone 13"
        case "iPhone14,2":  return "iPhone 13 Pro"
        case "iPhone14,3":  return "iPhone 13 Pro Max"
        case "iPhone14,7":  return "iPhone 14"
        case "iPhone14,8":  return "iPhone 14 Plus"
        case "iPhone15,2":  return "iPhone 14 Pro"
        case "iPhone15,3":  return "iPhone 14 Pro Max"
        case "iPhone15,4":  return "iPhone 15"
        case "iPhone15,5":  return "iPhone 15 Plus"
        case "iPhone16,1":  return "iPhone 15 Pro"
        case "iPhone16,2":  return "iPhone 15 Pro Max"
        case "iPhone17,1":  return "iPhone 16"
        case "iPhone17,2":  return "iPhone 16 Plus"
        case "iPhone17,3":  return "iPhone 16 Pro"
        case "iPhone17,4":  return "iPhone 16 Pro Max"
            
        case "i386","x86_64":   return "Simulator"
            
        default:  return identifier
        }
    }
    
    var appVersion: String{
        Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "1.0.0"
    }
    
    var restBattery: Int{
        UIDevice.current.isBatteryMonitoringEnabled = true
        return Int(ceilf(Device.batteryLevel*100))
    }
    
    var isFull: Bool{
        UIDevice.current.batteryState == .full
    }
    
    var inCharge: Bool{
        UIDevice.current.batteryState == .charging
    }
    
    var userLanguage: String {
        var languageStr:String = ""
        if let preferredLanguage = NSLocale.preferredLanguages.first {
            if let language = preferredLanguage.components(separatedBy: "-").first {
                languageStr = language
            }
        }
        return languageStr
    }

    var allDisk: Int64 {
        var fs = DeviceManager.emptyof(type: statfs.self)
        if statfs("/var",&fs) >= 0{
            return Int64(UInt64(fs.f_bsize) * fs.f_blocks)
        }
        return 0
    }
    
    var restDisk: Int64 {
        var fs = DeviceManager.emptyof(type: statfs.self)
        if statfs("/var",&fs) >= 0{
            return Int64(UInt64(fs.f_bsize) * fs.f_bavail)
        }
        return 0
    }
    
    var deviceTimeZone:String{
        TimeZone.current.abbreviation() ?? ""
    }
    
    
    var allMemory: Int64 {
        return Int64(ProcessInfo.processInfo.physicalMemory)
    }
 
    var restMemory:String {
        var vmStats = vm_statistics64()
        var infoCount = mach_msg_type_number_t(MemoryLayout.size(ofValue: vmStats) / MemoryLayout<integer_t>.size)
        let hostPort = mach_host_self()
        
        let kernReturn = withUnsafeMutablePointer(to: &vmStats) {
            $0.withMemoryRebound(to: integer_t.self, capacity: Int(infoCount)) {
                host_statistics64(hostPort, HOST_VM_INFO64, $0, &infoCount)
            }
        }
        
        guard kernReturn == KERN_SUCCESS else {
            return "error"
        }
        
        let freeMemory = Double(vm_page_size) * Double(vmStats.free_count + vmStats.inactive_count)
        return String(format: "%.f", freeMemory)
    }
    
    // wifi name
    var SSIDString: String {
        guard let unwrappedCFArrayInterfaces = CNCopySupportedInterfaces() else { return "" }
        guard let swiftInterfaces = (unwrappedCFArrayInterfaces as NSArray) as? [String] else { return "" }
        var SSID: String = ""
        for interface in swiftInterfaces {
            guard let unwrappedCFDictionaryForInterface = CNCopyCurrentNetworkInfo(interface as CFString) else { return "" }
            guard let SSIDDict = (unwrappedCFDictionaryForInterface as NSDictionary) as? [String: AnyObject] else { return "" }
            guard let ssid = SSIDDict["SSID"] as? String else { return "" }
            SSID = ssid
        }
        return SSID
    }
    
    var BSSIDString: String {
        guard let unwrappedCFArrayInterfaces = CNCopySupportedInterfaces() else { return "" }
        guard let swiftInterfaces = (unwrappedCFArrayInterfaces as NSArray) as? [String] else { return "" }
        var BSSID: String = ""
        for interface in swiftInterfaces {
            guard let unwrappedCFDictionaryForInterface = CNCopyCurrentNetworkInfo(interface as CFString) else { return "" }
            guard let SSIDDict = (unwrappedCFDictionaryForInterface as NSDictionary) as? [String: AnyObject] else { return "" }
            guard let bssid = SSIDDict["BSSID"] as? String else { return "" }
            let stringArray = bssid.components(separatedBy: ":-")
            var tempBSSID: String = ""
            stringArray.forEach { string in
                if string.count == 1 {
                    tempBSSID += String(format: "0%@", string)
                } else {
                    tempBSSID += string
                }
            }
            BSSID = tempBSSID
        }
        return BSSID
    }
    
    var mobileOperated: String {
        let info = CTTelephonyNetworkInfo()
        var supplier: String = ""
        if #available(iOS 12.0, *) {
            if let carriers = info.serviceSubscriberCellularProviders {
                if carriers.keys.count == 0 {
                    return ""
                } else {
                    for (index, carrier) in carriers.values.enumerated() {
                        guard carrier.carrierName != nil else { return "" }
                        if index == 0 {
                            supplier = carrier.carrierName!
                        } else {
                            supplier = supplier + "," + carrier.carrierName!
                        }
                    }
                    return supplier
                }
            } else{
                return ""
            }
        } else {
            if let carrier = info.subscriberCellularProvider {
                guard carrier.carrierName != nil else { return "" }
                return carrier.carrierName!
            } else{
                return ""
            }
        }
    }
    
    var IP: String {
        let networkType = netType
        switch networkType {
        case "WIFI":
            return WiFiIP
        default:
            return operatorsIP
        }
    }
    
    var WiFiIP: String {
        var address: String = ""
        var ifaddr : UnsafeMutablePointer<ifaddrs>? = nil
        guard getifaddrs(&ifaddr) == 0 else { return address }
        guard let firstAddr = ifaddr else { return address }
        for ifptr in sequence(first: firstAddr, next: { $0.pointee.ifa_next }) {
            let interface = ifptr.pointee
            // Check for IPV4 or IPV6 interface
            let addrFamily = interface.ifa_addr.pointee.sa_family
            if addrFamily == UInt8(AF_INET) || addrFamily == UInt8(AF_INET6) {
                // Check interface name
                let name = String(cString: interface.ifa_name)
                if name == "en0" {
                    // Convert interface address to a human readable string
                    var addr = interface.ifa_addr.pointee
                    var hostName = [CChar](repeating: 0, count: Int(NI_MAXHOST))
                    getnameinfo(&addr, socklen_t(interface.ifa_addr.pointee.sa_len), &hostName, socklen_t(hostName.count), nil, socklen_t(0), NI_NUMERICHOST)
                    address = String(cString: hostName)
                }
            }
        }
        freeifaddrs(ifaddr)
        return address
    }
    
    var operatorsIP: String {
        var addresses = [String]()
        var ifaddr : UnsafeMutablePointer<ifaddrs>? = nil
        if getifaddrs(&ifaddr) == 0 {
            var ptr = ifaddr
            while (ptr != nil) {
                let flags = Int32(ptr!.pointee.ifa_flags)
                var addr = ptr!.pointee.ifa_addr.pointee
                if (flags & (IFF_UP | IFF_RUNNING | IFF_LOOPBACK )) == (IFF_UP | IFF_RUNNING) {
                    if addr.sa_family == UInt8(AF_INET) || addr.sa_family == UInt8(AF_INET6) {
                        var hostname = [CChar](repeating: 0, count: Int(NI_MAXHOST))
                        if (getnameinfo(&addr, socklen_t(addr.sa_len), &hostname, socklen_t(hostname.count), nil, socklen_t(0), NI_NUMERICHOST) == 0) {
                            if let address = String(validatingUTF8: hostname) {
                                addresses.append(address)
                            }
                        }
                    }
                }
                ptr = ptr!.pointee.ifa_next
            }
            freeifaddrs(ifaddr)
        }
        if let ipStr = addresses.first {
            return ipStr
        } else {
            return ""
        }
    }
    
    
    var isBbroken: Bool {
        let appPath = "/Applications/"
        if FileManager.default.fileExists(atPath: appPath) {
            if let apps = try? FileManager.default.contentsOfDirectory(atPath: appPath) {
                if !apps.isEmpty {
                    return true
                }
            }
        }
        return false
    }
    
    var isUseSimulator: Bool {
        #if targetEnvironment(simulator)
        return true
        #else
        return false
        #endif
    }
    
    var WANIP: String {
        let ipURL = URL(string: "http://pv.sohu.com/cityjson?ie=utf-8")
        var ip: String = ""
        do {
            if let ipURL {
                ip = try String(contentsOf: ipURL, encoding: .utf8)
            }
        } catch {
            print("k-- WANIP:\(error)")
        }
        if ip.hasPrefix("var returnCitySN = ") {
            let range = NSRange(location: 0, length: 19)
            if let subRange = Range<String.Index>(range, in: ip) {
                ip.removeSubrange(subRange)
            }
            let nowIp = NSString(string: ip).substring(to: ip.count - 1)
            let data = nowIp.data(using: .utf8)
            var dict: [String: Any] = [:]
            do {
                if let data {
                    let object = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                    if let tempDict = object as? [String: Any] {
                        dict = tempDict
                    }
                }
            } catch {
                print("k-- WANIP:\(error)")
            }
            if let cip = dict["cip"] as? String {
                return cip
            }
        }
        return ""
    }
    
    var isVpnOn: Bool {
        guard let proxy = CFNetworkCopySystemProxySettings()?.takeUnretainedValue() else { return false }
        guard let dict = proxy as? [String: Any] else { return false }
        guard let scopedDict = dict["__SCOPED__"] as? [String: Any] else { return false }
        for key in scopedDict.keys {
            if (key == "tap") || (key == "tun") || (key == "ppp") || (key == "ipsec") || (key == "ipsec0") {
                return true
            }
        }
        return false
    }
    
    
    
    var isProxyOn: Bool {
        guard let proxy = CFNetworkCopySystemProxySettings()?.takeUnretainedValue() else { return false }
        guard let dict = proxy as? [String: Any] else { return false }
        guard let HTTPProxy = dict["HTTPProxy"] as? String else { return false }
        return HTTPProxy.count > 0
    }
    
    
    var netType: String {
        var zeroAddress = sockaddr_storage()
        bzero(&zeroAddress, MemoryLayout<sockaddr_storage>.size)
        zeroAddress.ss_len = __uint8_t(MemoryLayout<sockaddr_storage>.size)
        zeroAddress.ss_family = sa_family_t(AF_INET)
        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) { address in
                SCNetworkReachabilityCreateWithAddress(nil, address)
            }
        }
        guard let defaultRouteReachability = defaultRouteReachability else { return "NONE" }
        var flags = SCNetworkReachabilityFlags()
        let didRetrieveFlags = SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags)
        guard didRetrieveFlags && flags.contains(.reachable) && !flags.contains(.connectionRequired) else { return "NONE" }
        if flags.contains(.isWWAN) {
            return cellularModel
        } else {
            return "WIFI"
        }
    }
    
    var cellularModel: String {
        let info = CTTelephonyNetworkInfo()
        var status: String
        if #available(iOS 12.0, *) {
            guard let dict = info.serviceCurrentRadioAccessTechnology, let firstKey = dict.keys.first, let tempStatus = dict[firstKey] else { return "NONE" }
            status = tempStatus
        } else {
            guard let tempStatus = info.currentRadioAccessTechnology else { return "NONE" }
            status = tempStatus
        }
        if #available(iOS 14.1, *) {
            if (status == CTRadioAccessTechnologyNR) || (status == CTRadioAccessTechnologyNRNSA) {
                return "5G"
            }
        }
        switch status {
        case CTRadioAccessTechnologyGPRS,
             CTRadioAccessTechnologyEdge,
             CTRadioAccessTechnologyCDMA1x:
            return "2G"
        case CTRadioAccessTechnologyWCDMA,
             CTRadioAccessTechnologyHSDPA,
             CTRadioAccessTechnologyHSUPA,
             CTRadioAccessTechnologyeHRPD,
             CTRadioAccessTechnologyCDMAEVDORev0,
             CTRadioAccessTechnologyCDMAEVDORevA,
             CTRadioAccessTechnologyCDMAEVDORevB:
            return "3G"
        case CTRadioAccessTechnologyLTE:
            return "4G"
        default:
            return "OTHER"
        }
    }
  
    static func emptyof<T>(type:T.Type) -> T {
        let ptr = UnsafeMutablePointer<T>.allocate(capacity: MemoryLayout<T>.size)
        let val = ptr.pointee
        return val
    }
    
    var physicalSize: String{
        return String(format: "%.0f*%.0f", ScreenWidth,ScreenHeight)
    }
    
    var scHeight: CGFloat{
        UIScreen.main.nativeBounds.size.height
    }
    
    var scWidth: CGFloat{
        UIScreen.main.nativeBounds.size.width
    }
    
    var deviceInitTime: TimeInterval {
        if let systemAttributes = try? FileManager.default.attributesOfFileSystem(forPath: NSHomeDirectory()) {
            if let creationDate = systemAttributes[.creationDate] as? Date {
                return creationDate.timeIntervalSince1970
            }
        }
        return 0
    }
    
    var topNaviBar: CGFloat {
        return NavBarHeight
    }
    
    func getDeviceData() -> [String:Any] {
        let data = [
            "xfCvAzgJzkGNimXVoTMRM": [
                "pwSjbuLJShuniUaVjvwI": restDisk,
                "MoWvDPdqpTtkQxOtJWV": allDisk,
                "pvznPGdqNZzXPYaZAjfQEJEPZJ": allMemory,
                "jQHnbzaemIvuvVCLpvSJKHWKxohe": restMemory
            ],
            "vCRElwiqNRFOHBDjR": [
                "oiyalrpyGOaNEFIWsHrxsHPkDx": restBattery,
                "XWEWidlSWVGzOmfMLir": inCharge ? 1 : 0
            ],
            "BEOKTrJzoKkwDXk": [
                "EuzYntmOqipYrbUgqpYwCx": DeviceManager.getSystemVersion(),
                "xEualQNuMvwYfgGTWpRvptRXmS": "iPhone",
                "ymNauBrGvSaiXJrx": DeviceManager.getModelName(),
                "jIFtYFgffiAhSQzFYBMHECnvcG": ScreenHeight,
                "YKuwXEctavXXwsjDPwKKF": ScreenWidth,
                "OsapAjCeuBZZlVpcqZHWbiXaCtA": physicalSize,
                "JVpTAZaRJLeENzMLhkWMI": deviceInitTime,
            ],
            "jZSoqjmphMHbLQwzvPivXTNhhKBQk": [:],
            "HMKCwfakasYhJUkufuBbxBdQCXEv": [
              "DjdgNlOhqArMbZUIj": "0",
              "UGKBJisXPryvKjqkdGQ": isUseSimulator ? 1 : 0 ,
              "bOObvGJHuOnNPGJZjIYZcaH": isBbroken ? 1 : 0
            ],
            "rolIJJIENCiRTGDwjmvTm": appVersion.replacingOccurrences(of: ".", with: ""),
            "vHssufouMAbGxJJfWTkdpqTGbByM": appVersion,
            "NCmhLDUGJPtjLkKc": [
                "PjHgouHXtqqMitwXFR": deviceTimeZone,
                "SgWVawchvBbZjLzIvojzovFRJRNK": isProxyOn ? 1 : 0,
                "sjEzlKOFOWteLUhPUNVIKCD": isVpnOn ? 1 : 0,
                "MtGiVrFTQVaQhdekithgKJhRdbWm": mobileOperated,
                "sowjFixDjStchksidW": DeviceManager.getIDFV(),
                "bfXqypbTXAjCQBHdPhP": userLanguage,
                "OXDLlCUAaKxKpCdHLYUJ": netType,
                "BALsAzPfJaAQCzyIbBq": 1,
                "ySKKPKVxnkORKnXAsxJAcEKPGZgJmU": IP,
                "XuZBByvuxoIeMql": AppTrack.idfaID
            ],
            "CPqMsXsxylgbCEgnK":[
                "dnMIYciexijNMtOXz":[:],
                "DPvDzLvPZQRvzZILgBobyqjYTwm":0,
                "CLVEeBrPPzhQgnrIPrHNarh":[
                    "wYhkqnYEeUESimfIF":BSSIDString,
                    "arILzSxeCUtzZAlGVtFGgFXnpaEQ":BSSIDString,
                    "NnfawhNtmBUUfabHrKnvuPhg":SSIDString,
                    "QEqlaxHeWkQQaSVhbLx":SSIDString
                  ]
            ]
        ] as [String : Any]
        
        return ["gbDLHfZgaiKTPPaRo" : data]
    }
}
