//
//  LocationManager.swift
//  Weather
//
//  Created by Нияз Нуруллин on 08.01.2023.
//

import Foundation
import CoreLocation

class LocationManager {

    static let defaultManager = LocationManager()
    private let locationManager = CLLocationManager()

    func getPermissionStatus() -> CLAuthorizationStatus {
        let currentStatus = locationManager.authorizationStatus
        return currentStatus
    }

    func getPermission() {
        let currentStatus = locationManager.authorizationStatus
        if currentStatus == .notDetermined {
            locationManager.requestWhenInUseAuthorization()
        }
//        switch currentStatus {
//        case .notDetermined:
//        case .authorizedAlways, .authorizedWhenInUse:
//            locationManager.desiredAccuracy = 50
//            locationManager.startUpdatingLocation()
////            mapView.showsUserLocation = true
////            updateCurrentArea()
//        case .restricted:
//            debugPrint("Navigation isn't allowed.")
//        case .denied:
//            locationManager.stopUpdatingLocation()
////            mapView.showsUserLocation = false
//            debugPrint("Allow location tracking in settings.")
//        @unknown default:
//            preconditionFailure("Unknown error")
//        }
    }

    func getCoordinates(_ geoModel: GeoModel) -> (longitude: String, latitude: String)? {
        let featureMember = geoModel.response.geoObjectCollection.featureMember
        if !featureMember.isEmpty {
            let coordiatesArray = featureMember[0].geoObject.point.pos.components(separatedBy: " ")
            let lon = (coordiatesArray[0])
            let lat = (coordiatesArray[1])

            return (longitude: lon, latitude: lat)
        }

        return nil
    }
    
    func getName(_ geoModel: GeoModel) -> (country: String, city: String)? {
        let featureMember = geoModel.response.geoObjectCollection.featureMember
        if !featureMember.isEmpty {
            let namesArray = featureMember[0].geoObject.metaDataProperty.geocoderMetaData.adress.components(separatedBy: ", ")
            if namesArray.count >= 2 {
                let countyName = namesArray.first!
                let cityName = namesArray.last!
                return (country: countyName, city: cityName)
            }
        }

        return nil
    }
}


