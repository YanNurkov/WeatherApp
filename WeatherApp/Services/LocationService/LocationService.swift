//
//  LocationService.swift
//  WeatherApp
//
//  Created by Ян Нурков on 26.04.2023.
//

import Foundation
import CoreLocation

class LocationService: NSObject, CLLocationManagerDelegate {
    let locationManager = CLLocationManager()
    var locationUpdate: ((CLLocationCoordinate2D, String?) -> Void)?
    
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyKilometer
        locationManager.requestWhenInUseAuthorization()
    }
    
    func getUserLocation(completion: @escaping (CLLocationCoordinate2D, String?) -> Void) {
        locationUpdate = completion
        locationManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            let geocoder = CLGeocoder()
            geocoder.reverseGeocodeLocation(location) { placemarks, error in
                let cityName = placemarks?.first?.locality ?? placemarks?.first?.administrativeArea
                self.locationUpdate?(location.coordinate, cityName)
            }
            locationManager.stopUpdatingLocation()
        }
    }
}
