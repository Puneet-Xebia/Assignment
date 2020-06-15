
//
//  LocationManager.swift
//  Smart Dubai
//
//  Created by Puneet kumar  on 15/06/20.
//  Copyright © 2020 Puneet Kumar. All rights reserved.
//

import Foundation
import CoreLocation

protocol LocationManagerDelegate {
    func sendCurrentLocation(lat:Double,lon: Double)
}

class LocationManager: NSObject, CLLocationManagerDelegate {
    
    var locationManager: CLLocationManager?
    var lastLocation: CLLocation?
    var delegate: LocationManagerDelegate?
        
    private static let sharedlocationManager: LocationManager = {
        let locationManager = LocationManager()
        return locationManager
    }()
    
    private override init() {
        super.init()
        
        self.locationManager = CLLocationManager()
        guard let locationManager = self.locationManager else {  return }
        
        if CLLocationManager.authorizationStatus() == .notDetermined {
            locationManager.requestAlwaysAuthorization()
        }
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = 100
        locationManager.delegate = self
    }
    
    class func shared() -> LocationManager {
        return sharedlocationManager
    }
    
    func startUpdatingLocation() {
        self.locationManager?.startUpdatingLocation()
    }
    
    func stopUpdatingLocation() {
        self.locationManager?.stopUpdatingLocation()
    }
    
    internal func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {

        guard let location = locations.last else {
            return
        }
        
        stopUpdatingLocation()
        
        self.lastLocation = location
        self.delegate?.sendCurrentLocation(lat: (self.lastLocation?.coordinate.latitude)!, lon: (self.lastLocation?.coordinate.longitude)!)
        
    }
}
