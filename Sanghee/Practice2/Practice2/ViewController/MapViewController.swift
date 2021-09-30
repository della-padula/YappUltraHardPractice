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
    private var annotations: [MKPointAnnotation] = [] {
        didSet {
            showAnnotations()
            addCenterAnnotation()
        }
    }
    private var centerAnnotation: MKPointAnnotation? {
        didSet {
            if let oldValue = oldValue {
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
        mapView.showsCompass = true
        mapView.showsScale = true
        
        view.addSubview(mapView)
        mapView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor)
    }
    
    private func addLongGesture() {
        let longGesture = UILongPressGestureRecognizer(target: self, action: #selector(getCoordinate))
        view.addGestureRecognizer(longGesture)
    }
    
    @objc
    private func getCoordinate(_ longGesture: UILongPressGestureRecognizer) {
        let touchPoint = longGesture.location(in: mapView)
        let coordinate = mapView.convert(touchPoint, toCoordinateFrom: mapView)
        addAnnotation(coordinate)
    }
    
    private func addAnnotation(_ coordinate: CLLocationCoordinate2D) {
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        
        if annotations.count < 11 && !annotations.contains(annotation) {
            annotations.append(annotation)
        }
    }
    
    private func showAlert(_ func: () -> Void) {
        let alert = UIAlertController(title: "위치 추가", message: "위치를 추가하시겠습니까?", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "예", style: .destructive) { _ in
            print("예")
        }
        let noAction = UIAlertAction(title: "아니요", style: .cancel)

        alert.addAction(okAction)
        alert.addAction(noAction)
        present(alert, animated: true, completion: nil)
    }
    
    private func showAnnotations() {
        for annotation in annotations {
            mapView.addAnnotation(annotation)
        }
    }
    
    private func addCenterAnnotation() {
        let count = Double(annotations.count)
        let latitude = annotations.map({ $0.coordinate }).map({ $0.latitude }).reduce(0, +) / count
        let longitude = annotations.map({ $0.coordinate }).map({ $0.longitude }).reduce(0, +) / count
        let coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)

        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        centerAnnotation = annotation
        if let centerAnnotation = centerAnnotation {
            mapView.addAnnotation(centerAnnotation)
        }
    }
    
    private func deleteAnnotation(_ annotation: MKAnnotation) {
        mapView.removeAnnotation(annotation)
    }
}

extension MapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let identifier = "LocationMark"
        let view = MKAnnotationView(annotation: annotation, reuseIdentifier: identifier)
        
        if annotation.coordinate == locationManager.location?.coordinate {
            view.image = UIImage(systemName: "figure.stand")
        } else if annotation.coordinate == centerAnnotation?.coordinate {
            view.image = UIImage(systemName: "pin.fill")
        } else {
            view.image = UIImage(systemName: "pin")
        }
        
        return view
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        print("마크 선택하면 삭제")
        if let annotation = view.annotation {
            deleteAnnotation(annotation)
        }
    }
}
