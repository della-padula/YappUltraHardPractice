//
//  CustomAnnotationView.swift
//  Practice2
//
//  Created by leeesangheee on 2021/10/01.
//

import MapKit
import UIKit

class CustomAnnotationView: MKMarkerAnnotationView {
    static let identifier = "CustomAnnotation"
    
    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        
        canShowCallout = true
        leftCalloutAccessoryView = UIButton(type: .infoLight)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
