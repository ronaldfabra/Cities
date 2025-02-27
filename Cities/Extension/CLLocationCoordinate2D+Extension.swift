//
//  CLLocationCoordinate2D+Extension.swift
//  Cities
//
//  Created by Ronal Fabra Jimenez on 27/02/25.
//


import MapKit

extension CLLocationCoordinate2D: @retroactive Equatable {
    public static func == (lhs: CLLocationCoordinate2D, rhs: CLLocationCoordinate2D) -> Bool {
        lhs.latitude == rhs.latitude &&
        lhs.longitude == rhs.longitude
    }
}
