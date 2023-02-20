//
//  UserDefaultSettings.swift
//  Weather
//
//  Created by Нияз Нуруллин on 23.01.2023.
//

import Foundation

enum TemperatureUnits: Int {
    case celsius = 0
    case fahrenheit = 1
}

enum VelocityUnits: Int {
    case meterPerSecond = 0
    case milesPerHour = 1
}

enum TimeFormat: Int {
    case fullDay = 0
    case halfDay = 1
}


struct UserDefaultSettings {

    static var temperatureUnits: TemperatureUnits {
        set {
            UserDefaults.standard.set(newValue.rawValue, forKey: "TemperatureUnits")
            UserDefaults.standard.synchronize()
        }
        get {
            return TemperatureUnits(rawValue: UserDefaults.standard.integer(forKey: "TemperatureUnits")) ?? .celsius
        }
    }

    static var velocityUnits: VelocityUnits {
        set {
            UserDefaults.standard.set(newValue.rawValue, forKey: "VelocityUnits")
            UserDefaults.standard.synchronize()
        }
        get {
            return VelocityUnits(rawValue: UserDefaults.standard.integer(forKey: "VelocityUnits")) ?? .meterPerSecond
        }
    }

    static var timeFormat: TimeFormat {
        set {
            UserDefaults.standard.set(newValue.rawValue, forKey: "TimeFormat")
            UserDefaults.standard.synchronize()
        }
        get {
            return TimeFormat(rawValue: UserDefaults.standard.integer(forKey: "TimeFormat")) ?? .fullDay
        }
    }


    // храниние статуса уведомлений

}
