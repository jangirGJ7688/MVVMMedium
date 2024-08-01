//
//  LocationManager.swift
//  MVVMMedium
//
//  Created by Ganpat Jangir on 01/08/24.
//

import Foundation
import CoreLocation


class LocationManager: NSObject, CLLocationManagerDelegate {
    static let shared = LocationManager()
    fileprivate var locationManager: CLLocationManager?
    var latitude: CLLocationDegrees = 0.0
    var longitude: CLLocationDegrees = 0.0
    
    func initializeLocationManager() {
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        locationManager?.desiredAccuracy = kCLLocationAccuracyBest
        locationManager?.requestAlwaysAuthorization()
        locationManager?.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let locationValue: CLLocationCoordinate2D = manager.location!.coordinate
        latitude = locationValue.latitude
        longitude = locationValue.longitude
        if latitude != 0.0 && longitude != 0.0 {
            notifyLocationAvailability()
        }
    }
    
    private func notifyLocationAvailability() {
        NotificationCenter.default.post(name: Notification.Name("LocationAvailable"), object: nil)
    }
    
}
