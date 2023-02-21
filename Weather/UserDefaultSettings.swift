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

enum NotificationStatus: Int {
    case off = 0
    case on = 1
}

struct UserDefaultSettings {

    static var temperatureUnit: TemperatureUnits {
        set {
            UserDefaults.standard.set(newValue.rawValue, forKey: "TemperatureUnits")
            UserDefaults.standard.synchronize()
        }
        get {
            return TemperatureUnits(rawValue: UserDefaults.standard.integer(forKey: "TemperatureUnits")) ?? .celsius
        }
    }

    static var velocityUnit: VelocityUnits {
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

    static var notificationStatus: NotificationStatus {
        set {
            UserDefaults.standard.set(newValue.rawValue, forKey: "NotificationStatus")
            UserDefaults.standard.synchronize()
        }
        get {
            return NotificationStatus(rawValue: UserDefaults.standard.integer(forKey: "NotificationStatus")) ?? .off
        }
    }

}
