//
//  LocationManager.swift
//  Peek-a-Book
//
//  Created by Arif Rahman on 28/07/21.
//

import Foundation
import CoreLocation

class LocationManager {
    static let shared = LocationManager()
    
    private let locationManager = CLLocationManager()
    
    func getExposedLocation() -> CLLocation? { return locationManager.location }
    
    func getPlace(for location: CLLocation,
                      completion: @escaping (CLPlacemark?) -> Void) {
        
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(location) { placemarks, error in
            guard error == nil else {
                print("*** Error in \(#function): \(error!.localizedDescription)")
                completion(nil)
                return
            }
            
            guard let placemark = placemarks?[0] else {
                print("*** Error in \(#function): placemark is nil")
                completion(nil)
                return
            }
            
            completion(placemark)
        }
        
    }
    
    func getDistance(yourLocation: CLLocation, anotherLocation: CLLocation) -> CLLocationDistance {
        let distance = yourLocation.distance(from: anotherLocation)
        return distance
    }
         
}
