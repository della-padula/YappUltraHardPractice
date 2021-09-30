//
//  LocationManager.swift
//  Practice2
//
//  Created by leeesangheee on 2021/09/30.
//

import CoreLocation

class LocationManager: NSObject, CLLocationManagerDelegate {
    static let shared = LocationManager()
    
    var manager: CLLocationManager = CLLocationManager()
    var location: CLLocation?
    
    override init() {
        super.init()
        
        manager.delegate = self
        location = manager.location
    }

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            askLocation()
        }
    }
    
    func askLocation() {
        switch manager.authorizationStatus {
        case .authorizedAlways: manager.startUpdatingLocation()
        case .authorizedWhenInUse: manager.requestAlwaysAuthorization()
        case .notDetermined: manager.requestWhenInUseAuthorization()
        case .restricted, .denied: break
        @unknown default: break
        }
    }
}
