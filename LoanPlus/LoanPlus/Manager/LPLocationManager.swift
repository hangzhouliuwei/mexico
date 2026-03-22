//
//  LPLocationManager.swift
//  LoanPlus
//
//  Created by 刘巍 on 2024/11/25.
//

import CoreLocation

let Localed = LPLocationManager.shared

class LPLocationManager:NSObject, CLLocationManagerDelegate {
    
    static let shared = LPLocationManager()
    
    private var locationManager = CLLocationManager()
    
    var blocks:((Bool,[String:Any]?) -> Void)?
    
    var longFloat:CGFloat = 0.0
    var latiFloat:CGFloat = 0.0
    
    func getLocationInfo(result:@escaping ((Bool,[String:Any]?) -> Void)){
        self.blocks = result
        updateState()
        starts()
    }
    
    func starts(){
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
        locationManager.startUpdatingLocation()
    }
    
    private func updateState(){
        var status: CLAuthorizationStatus
        if #available(iOS 14.0, *) {
            status = locationManager.authorizationStatus
        } else {
            status = CLLocationManager.authorizationStatus()
        }
        switch status {
        case .denied,.restricted:
            self.blocks?(false,nil)
            self.blocks = nil
        default:
            break;
        }
    }
    
    private func rebackLocation(info:[String:Any]) {
        locationManager.stopUpdatingLocation()
        self.blocks?(true,info)
        self.blocks = nil
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        guard let location = locations.last else { return }
        
        latiFloat = location.coordinate.latitude
        longFloat = location.coordinate.longitude
        
        let geocoder = CLGeocoder()
        let geocoderLocation = CLLocation(latitude: latiFloat, longitude: longFloat)
        geocoder.reverseGeocodeLocation(geocoderLocation) { [weak self] (array, error) in
            guard let `self` = self else { return }
            if let array, !array.isEmpty {
                if let markDict = array.first {
                    let countryCode = markDict.isoCountryCode ?? ""
                    let country = markDict.country ?? ""
                    
                    var street = markDict.thoroughfare ?? ""
                    if let subStreet = markDict.subThoroughfare {
                        street += subStreet
                    }
                    
                    let city = markDict.locality ?? ""
                    let province = markDict.administrativeArea ?? city
                    let district = markDict.subLocality ?? markDict.locality ?? markDict.administrativeArea ?? ""
                    
                    let info:[String:Any] = ["pRlzUjwYyUacQvanKcYTZXKK": province,
                                            "OHfyTejODxVlfPiTjcx": countryCode,
                                            "rkCbjNIhBrEZpFVlbCyJuMVIQCa": country,
                                            "ccJxLjazHdicNVMmCRPZIebMBUln": street,
                                            "GVqqUZUXuJTgROSUwUTRnsaD": latiFloat,
                                            "uWWsWqAEznLwpCk": longFloat,
                                            "VLVaurpsVWxUOio": city,
                                            "ffYewepKbprUVSnnCqshGVsqTib": district
                                           ]
                    self.rebackLocation(info: info)
                    
                }
            }
            
        }
        
    }

    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        updateState()
    }
    
}

