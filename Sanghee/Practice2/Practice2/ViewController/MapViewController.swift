//
//  MapViewController.swift
//  Practice2
//
//  Created by leeesangheee on 2021/09/30.
//

import MapKit
import UIKit

class MapViewController: UIViewController, MKMapViewDelegate {
    private let locationManager = LocationManager.shared
    
    private let mapView = MKMapView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        locationManager.askLocation()
        addAnnotation()
        addMapView()
        setMapView()
    }
    
    private func setMapView() {
        mapView.delegate = self
        mapView.mapType = .standard
        mapView.showsUserLocation = true
    }
    
    private func addMapView() {
        view.addSubview(mapView)
        mapView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor)
    }
    
    private func registerMapAnnotationViews() {
        mapView.register(MKAnnotationView.self, forAnnotationViewWithReuseIdentifier: "Annotation")
    }
    
    private func addAnnotation() {
        let point = MKPointAnnotation()
        point.coordinate = CLLocationCoordinate2D(latitude: 35, longitude: 130)
        point.title = "TITLE"
        
        if let location = locationManager.location {
            point.coordinate = location.coordinate
        }
        
        mapView.addAnnotation(point)
    }
    
}
