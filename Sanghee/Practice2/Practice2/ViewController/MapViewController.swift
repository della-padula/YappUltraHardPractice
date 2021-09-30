//
//  MapViewController.swift
//  Practice2
//
//  Created by leeesangheee on 2021/09/30.
//

import MapKit
import UIKit

class MapViewController: UIViewController {
    private let locationManager = LocationManager.shared
    private var coordinates: [CLLocationCoordinate2D] = [] {
        didSet {
            showAnnotations()
            addCenterAnnotation()
        }
    }
    private var centerAnnotation: MKPointAnnotation? {
        didSet {
            if let oldValue = oldValue, let centerAnnotation = centerAnnotation {
                deleteAnnotation(oldValue)
            }
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
    
    private func showAlert() {
        let alert = UIAlertController(title: "위치 추가", message: "위치를 추가하시겠습니까?", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "예", style: .destructive) { _ in
            print("예")
        }
        let noAction = UIAlertAction(title: "아니요", style: .cancel)

        alert.addAction(okAction)
        alert.addAction(noAction)
        present(alert, animated: true, completion: nil)
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
        for coordinate in coordinates {
            let annotation = MKPointAnnotation()
            annotation.coordinate = coordinate
            mapView.addAnnotation(annotation)
        }
    }
    
    private func addCenterAnnotation() {
        let count = Double(coordinates.count)
        let latitude = coordinates.map({ $0.latitude }).reduce(0, +) / count
        let longitude = coordinates.map({ $0.longitude }).reduce(0, +) / count
        let coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        
        centerAnnotation = annotation
        if let centerAnnotation = centerAnnotation {
            mapView.addAnnotation(centerAnnotation)
        }
    }
    
    
    private func deleteAnnotation(_ annotation: MKPointAnnotation) {
        mapView.removeAnnotation(annotation)
    }
}

extension MapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let identifier = "LocationMark"
        let view = MKAnnotationView(annotation: annotation, reuseIdentifier: identifier)
        view.image = UIImage(systemName: "pin.circle.fill")
        return view
    }
}
