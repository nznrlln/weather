//
//  LocationManager.swift
//  Weather
//
//  Created by Нияз Нуруллин on 08.01.2023.
//

import Foundation
import CoreLocation

class LocationManager {

    class func getPermissionStatus() -> CLAuthorizationStatus {
        let locationManager = CLLocationManager()
        let currentStatus = locationManager.authorizationStatus
        return currentStatus
//        switch currentStatus {
//        case .notDetermined:
//            locationManager.requestWhenInUseAuthorization()
//
//        case .authorizedAlways, .authorizedWhenInUse:
//            locationManager.desiredAccuracy = 50
//            locationManager.startUpdatingLocation()
//            mapView.showsUserLocation = true
//            updateCurrentArea()
//
//        case .restricted:
//            debugPrint("Navigation isn't allowed.")
//
//        case .denied:
//            locationManager.stopUpdatingLocation()
//            mapView.showsUserLocation = false
//            debugPrint("Allow location tracking in settings.")
//
//        @unknown default:
//            preconditionFailure("Unknown error")
//        }
    }
}


