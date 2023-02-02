//
//  AlertHelper.swift
//  Weather
//
//  Created by Нияз Нуруллин on 28.01.2023.
//

import Foundation
import UIKit

class AlertHelper {

    static let defaultHelper = AlertHelper()

    private init() {
    }

    func addCityAlert() -> UIAlertController {
        let alertController = UIAlertController(title: "Добавить город", message: nil, preferredStyle: .alert)
        alertController.addTextField { textField in
            textField.placeholder = "Название города"
        }

        let createAction = UIAlertAction(title: "Добавить", style: .default) { [weak self] action in
            if let cityName = alertController.textFields![0].text,
               cityName != "" {
                NetworkManager.defaultManager.geoRequest(cityName) { geoModel in
                    CoreDataManager.defaultManager.addCityWithWeatherData(geoModel: geoModel)
//                    CoreDataManager.defaultManager.addCity(geoModel: geoModel)
                }
            }
        }
        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel)

        alertController.addAction(createAction)
        alertController.addAction(cancelAction)

        return alertController
    }

    func showErrorAlert(error: String) -> UIAlertController {
        let alertController = UIAlertController(title: "Ошибка", message: error, preferredStyle: .alert)
        let closeAction = UIAlertAction(title: "Закрыть", style: .cancel)
        alertController.addAction(closeAction)

        return alertController
    }

}
