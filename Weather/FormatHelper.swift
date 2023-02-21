//
//  FormatHelper\.swift
//  Weather
//
//  Created by Нияз Нуруллин on 20.02.2023.
//

import Foundation

class FormatHelper {
    static let defaultHelper = FormatHelper()

    //    private let dateFormatter = DateFormatter()
    private let measurementFormatter = MeasurementFormatter()

    private init() {}

    func getLocalizedTemperature(from temperature: Int16) -> String {
        switch UserDefaultSettings.temperatureUnit {

        case .celsius:
//            let celsius = Measurement(value: Double(temperature), unit: UnitTemperature.celsius).value
//            let intCelsius = Int(celsius)

//            measurementFormatter.unitStyle = .short
//            let stringCelsius = measurementFormatter.string(from: celsius)
            return "\(temperature)°"
        case .fahrenheit:
            let celsius = Measurement(value: Double(temperature), unit: UnitTemperature.celsius)
            let fahrenheit = celsius.converted(to: .fahrenheit).value
            let intFahrenheit = Int(fahrenheit)
//            measurementFormatter.unitStyle = .short
//            let stringFahrenheit = measurementFormatter.string(from: fahrenheit)
            return "\(intFahrenheit)°"
        }
    }

    func getLocalizedVelocity(from velocity: Int16) -> String {
        switch UserDefaultSettings.velocityUnit {

        case .meterPerSecond:
            return "\(velocity) м/с"
        case .milesPerHour:
            let meters = Measurement(value: Double(velocity), unit: UnitSpeed.metersPerSecond)
            let miles = meters.converted(to: .milesPerHour).value
            let intMiles = Int(miles)

//            let stringMiles = measurementFormatter.string(from: miles)
            return "\(intMiles) ми/ч"
        }
    }

    func getLocalizedHours() -> String {
        switch UserDefaultSettings.timeFormat {
        case .fullDay:
            return "HH:mm"
        case .halfDay:
            return "hh:mm a"
        }

    }
    
}
    /*
    Исходные из JSON
    dateFormat =

     "yyyy-MM-dd'T'HH:mm:ss"

     "HH:mm, E dd MMMM"

     "HH:mm"

     "yyyy-MM-dd"
     
     "dd/MM"

     "E dd/MM"

     "dd/MM E"
     */

