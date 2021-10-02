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
    private let annotationManager = AnnotationManager.shared
    private let mapView = MKMapView()
    
    private var annotations: [MKPointAnnotation] = [] {
        didSet {
            showAnnotations()
            addCenterAnnotation()
            zoomMapView()
        }
    }
    private var centerAnnotation: MKPointAnnotation? {
        didSet {
            if let oldValue = oldValue {
                deleteAnnotation(oldValue)
            }
        }
    }
    
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
        mapView.register(CustomAnnotationView.self, forAnnotationViewWithReuseIdentifier: CustomAnnotationView.identifier)
        
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
            showAlert(annotation: annotation, isForAdding: true)
        }
    }
    
    private func addCenterAnnotation() {
        guard annotations.count > 1 else {
            centerAnnotation = nil
            return
        }
    
        let annotation = MKPointAnnotation()
        annotation.coordinate = annotationManager.getCenterCoordinate(annotations)
        centerAnnotation = annotation
        if let centerAnnotation = centerAnnotation {
            mapView.addAnnotation(centerAnnotation)
        }
    }
    
    private func showAnnotations() {
        for annotation in annotations {
            mapView.addAnnotation(annotation)
        }
    }
    
    private func deleteAnnotation(_ annotation: MKAnnotation) {
        mapView.removeAnnotation(annotation)
    }
    
    private func zoomMapView() {
        guard annotations.count > 1 else { return }
        
        var zoomRect: MKMapRect = MKMapRect.null
        let padding: CGFloat = 50

        for annotation in annotations {
            let point = MKMapPoint(annotation.coordinate)
            let rect = MKMapRect(x: point.x, y: point.y, width: 0.1, height: 0.1)
            
            zoomRect = zoomRect.isNull ? rect : zoomRect.union(rect)
        }
        
        mapView.setVisibleMapRect(zoomRect, edgePadding: UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding), animated: true)
    }
    
    private func addTextLabel(_ annotationView: MKAnnotationView) {
        let textLabel = UILabel()

        textLabel.textAlignment = .center
        textLabel.font = UIFont.boldSystemFont(ofSize: 12)
        textLabel.text = "중앙 위치"

        annotationView.addSubview(textLabel)
        textLabel.anchor(bottom: annotationView.bottomAnchor, paddingBottom: 40)
        textLabel.centerX(inView: annotationView)
    }
    
    private func showAlert(annotation: MKPointAnnotation, isForAdding: Bool) {
        let alert = UIAlertController(title: isForAdding ? "위치 추가" : "위치 삭제",
                                      message: isForAdding ? "위치를 추가하시겠습니까?" : "위치를 삭제하시겠습니까?",
                                      preferredStyle: .alert)
        let okAction = UIAlertAction(title: "예", style: .destructive) { _ in
            if isForAdding {
                self.annotations.append(annotation)
            } else {
                self.annotations = self.annotations.filter({ $0 != annotation })
                self.deleteAnnotation(annotation)
            }
            
        }
        let noAction = UIAlertAction(title: "아니요", style: .cancel)

        alert.addAction(okAction)
        alert.addAction(noAction)
        present(alert, animated: true, completion: nil)
    }
}

extension MapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let annotationView = CustomAnnotationView(annotation: annotation, reuseIdentifier: CustomAnnotationView.identifier)
        switch annotation.coordinate {
        case mapView.userLocation.coordinate: annotationView.markerTintColor = .systemGray
        case centerAnnotation?.coordinate:
            annotationView.markerTintColor = .systemRed
            addTextLabel(annotationView)
        default: annotationView.markerTintColor = .systemBlue
        }

        return annotationView
    }
    
    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
        let region = MKCoordinateRegion(center: userLocation.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
        mapView.setRegion(region, animated: true)
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        if let annotationView = view.annotation {
            guard annotations.map({ $0.coordinate }).contains(annotationView.coordinate) else { return }
            guard let annotation = annotations.filter({ $0.coordinate == annotationView.coordinate }).first else { return }

            showAlert(annotation: annotation, isForAdding: false)
        }
    }
}
