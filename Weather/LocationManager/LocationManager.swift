//
//  LocationManager.swift
//  Weather
//
//  Created by Нияз Нуруллин on 08.01.2023.
//

import Foundation
import CoreLocation

protocol LocationManagerDelegate {
    func didChangeAuthorizationAction()
}

class LocationManager: NSObject {

    var vcDelegate: LocationManagerDelegate?

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
    }

    func startLocation() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = 50
        locationManager.startUpdatingLocation()
    }

    func getCLCoordinates() -> (longitude: String, latitude: String)? {
        guard let coordinates = locationManager.location?.coordinate else { return nil }
        let lon = coordinates.longitude
        let lat = coordinates.latitude

        return (String(lon), String(lat))
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


// MARK: - CLLocationManagerDelegate

extension LocationManager: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        vcDelegate?.didChangeAuthorizationAction()
    }

}
