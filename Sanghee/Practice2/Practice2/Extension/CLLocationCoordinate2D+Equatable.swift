//
//  CLLocationCoordinate2D+Equatable.swift
//  Practice2
//
//  Created by leeesangheee on 2021/10/01.
//

import CoreLocation

extension CLLocationCoordinate2D: Equatable {}

public func ==(lhs: CLLocationCoordinate2D, rhs: CLLocationCoordinate2D) -> Bool {
    return lhs.latitude == rhs.latitude && lhs.longitude == rhs.longitude
}
