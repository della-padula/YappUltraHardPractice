//
//  MKMapView+Zoom.swift
//  Practice2
//
//  Created by leeesangheee on 2021/10/01.
//

import MapKit
import UIKit

extension MKMapView {
    func zoomMapView(in annotations: [MKAnnotation], andShow show: Bool) {
        var zoomRect: MKMapRect = MKMapRect.null

        for annotation in annotations {
            let aPoint = MKMapPoint(annotation.coordinate)
            let rect = MKMapRect(x: aPoint.x, y: aPoint.y, width: 0.1, height: 0.1)
            if zoomRect.isNull {
                zoomRect = rect
            } else {
                zoomRect = zoomRect.union(rect)
            }
        }
        if(show) {
            addAnnotations(annotations)
        }
        setVisibleMapRect(zoomRect, edgePadding: UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20), animated: true)
    }
}
