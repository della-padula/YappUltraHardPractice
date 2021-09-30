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
    private var coordinates: [CLLocationCoordinate2D] = [] {
        didSet {
            showAnnotations()
        }
    }
    
    private let mapView = MKMapView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        locationManager.askLocation()
        
        configureMapView()
        addLongGesture()
    }
    
    private func configureMapView() {
        mapView.delegate = self
        mapView.mapType = .standard
        mapView.showsUserLocation = true
        
        view.addSubview(mapView)
        mapView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor)
    }
    
    private func addLongGesture() {
        let longGesture = UILongPressGestureRecognizer(target: self, action: #selector(addCoordinate))
        view.addGestureRecognizer(longGesture)
    }
    
    @objc
    private func addCoordinate(_ longGesture: UILongPressGestureRecognizer) {
        let touchPoint = longGesture.location(in: mapView)
        let coordinate = mapView.convert(touchPoint, toCoordinateFrom: mapView)
        
        if coordinates.count < 11 && !coordinates.contains(coordinate) {
            coordinates.append(coordinate)
        }
    }
    
    private func showAnnotations() {
        coordinates.forEach {
            let annotation = MKPointAnnotation()
            annotation.coordinate = $0
            mapView.addAnnotation(annotation)
        }
    }
}
