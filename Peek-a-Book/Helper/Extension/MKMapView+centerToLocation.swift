//
//  MKMapView+centerToLocation.swift
//  Peek-a-Book
//
//  Created by Arif Rahman on 28/07/21.
//

import Foundation
import MapKit
extension MKMapView {
    func centerToLocation(_ location: CLLocation, regionRadius: CLLocationDistance = 500) {
      let coordinateRegion = MKCoordinateRegion(
        center: location.coordinate,
        latitudinalMeters: regionRadius,
        longitudinalMeters: regionRadius)
      setRegion(coordinateRegion, animated: true)
    }

}
