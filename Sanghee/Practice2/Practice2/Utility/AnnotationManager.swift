//
//  AnnotationManager.swift
//  Practice2
//
//  Created by leeesangheee on 2021/10/01.
//

import MapKit
import UIKit

class AnnotationManager {
    static let shared = AnnotationManager()
    
    private init() { }

    func getCenterCoordinate(_ annotations: [MKAnnotation]) -> CLLocationCoordinate2D {
        let count = Double(annotations.count)
        let latitude = annotations.map({ $0.coordinate }).map({ $0.latitude }).reduce(0, +) / count
        let longitude = annotations.map({ $0.coordinate }).map({ $0.longitude }).reduce(0, +) / count
        let coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        
        return coordinate
    }
    
    func getImageSystemName(_ coordinate: CLLocationCoordinate2D, _ centerAnnotation: MKPointAnnotation) -> String {
        switch coordinate {
        case LocationManager.shared.location?.coordinate: return "figure.stand"
        case centerAnnotation.coordinate: return "pin.fill"
        default: return "pin"
        }
    }
}
