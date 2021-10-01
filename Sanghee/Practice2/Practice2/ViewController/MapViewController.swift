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
        mapView.register(CustomAnnotationView.self, forAnnotationViewWithReuseIdentifier: CustomAnnotationView.identifier)
        
        view.addSubview(mapView)
        mapView.anchor(width: view.bounds.width, height: view.bounds.height)
        mapView.center(inView: view)
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
            let alert = UIAlertController(title: "위치 추가", message: "위치를 추가하시겠습니까?", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "예", style: .destructive) { _ in
                self.annotations.append(annotation)
            }
            let noAction = UIAlertAction(title: "아니요", style: .cancel)

            alert.addAction(okAction)
            alert.addAction(noAction)
            present(alert, animated: true, completion: nil)
        }
    }
    
    private func showAnnotations() {
        for annotation in annotations {
            mapView.addAnnotation(annotation)
        }
    }
    
    private func addCenterAnnotation() {
        let count = Double(annotations.count)
        if count < 2 {
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
    
    private func deleteAnnotation(_ annotation: MKAnnotation) {
        mapView.removeAnnotation(annotation)
    }
    
    private func zoomMapView() {
        if annotations.count < 2 { return }
        var zoomRect: MKMapRect = MKMapRect.null
        let space: CGFloat = 50

        for annotation in annotations {
            let point = MKMapPoint(annotation.coordinate)
            let rect = MKMapRect(x: point.x, y: point.y, width: 0.1, height: 0.1)
            if zoomRect.isNull {
                zoomRect = rect
            } else {
                zoomRect = zoomRect.union(rect)
            }
        }
        
        mapView.setVisibleMapRect(zoomRect, edgePadding: UIEdgeInsets(top: space, left: space, bottom: space, right: space), animated: true)
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
        if let annotation = view.annotation {
            if annotation.coordinate == mapView.userLocation.coordinate || annotation.coordinate == centerAnnotation?.coordinate { return }
            let alert = UIAlertController(title: "위치 삭제", message: "위치를 삭제하시겠습니까?", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "예", style: .destructive) { _ in
                self.annotations = self.annotations.filter({ $0.coordinate != view.annotation?.coordinate })
                self.deleteAnnotation(annotation)
            }
            let noAction = UIAlertAction(title: "아니요", style: .cancel)

            alert.addAction(okAction)
            alert.addAction(noAction)
            present(alert, animated: true, completion: nil)
        }
    }
}
