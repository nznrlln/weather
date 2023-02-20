//
//  CoreDataHelper.swift
//  Weather
//
//  Created by Нияз Нуруллин on 20.01.2023.
//

import Foundation
import UIKit

final class CoreDataHelper {
    static let defaultHelper = CoreDataHelper()

    func getTime(from unixTime: Int) -> String {
        let date = Date(timeIntervalSince1970: Double(unixTime))

        let dateFormatter = DateFormatter()
        // в перспективе привязать к часовому поясу конретного города
        dateFormatter.timeZone = .current
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        let localDate = dateFormatter.string(from: date)

        return localDate
    }

    func getMoonphaseText(from phaseIndex: Double) -> String {
        if phaseIndex == 0 {
            return "Новолуние"
        } else if phaseIndex > 0, phaseIndex < 0.25 {
            return "Растущий месяц"
        } else if phaseIndex == 0.25 {
            return "Первая четверть"
        } else if phaseIndex > 0.25, phaseIndex < 0.5 {
            return "Растущая луна"
        } else if phaseIndex == 0.5 {
            return "Полнолуние"
        } else if phaseIndex > 0.5, phaseIndex < 0.75 {
            return "Убывающая луна"
        } else if phaseIndex == 0.75 {
            return "Последняя четверть"
        } else if phaseIndex > 0.75, phaseIndex < 1 {
            return "Убывающий месяц"
        } else {
            return "Out of range"
        }
    }

    func getAQIScore(from aqi: Int) -> String {
        if (0...20).contains(aqi) {
            return "Хорошо"
        } else if (21...40).contains(aqi) {
            return "Удовлетворительно"
        } else if (41...60).contains(aqi) {
            return "Плохо для чувствительных"
        } else if (61...80).contains(aqi) {
            return "Плохо"
        } else if (81...90).contains(aqi) {
            return "Очень плохо"
        } else if (91...100).contains(aqi) {
            return "Опасно"
        } else {
            return "Out of range"
        }
    }

    func getAQIDescription(from aqi: Int) -> String {
        if (0...20).contains(aqi) {
            return "Качество воздуха считается удовлетворительным, и загрязнение воздуха представляется незначительным в пределах нормы."
        } else if (21...40).contains(aqi) {
            return "Качество воздуха является приемлемым, однако некоторые загрязнители могут представлять опасность для людей, являющихся особо чувствительными к загрязнению воздуха."
        } else if (41...60).contains(aqi) {
            return "Может оказывать эффект на особо чувствительную группу лиц. На среднего представителя не оказывает видимого воздействия."
        } else if (61...80).contains(aqi) {
            return "Каждый может начать испытывать последствия для своего здоровья; особо чувствительные люди могут испытывать более серьезные последствия."
        } else if (81...90).contains(aqi) {
            return "Опасность для здоровья от чрезвычайных условий. Это отразится, вероятно, на всем населении."
        } else if (91...100).contains(aqi) {
            return "Опасность для здоровья: каждый человек может испытывать более серьезные последствия для здоровья."
        } else {
            return "Out of range"
        }
    }

    func getAQIColor(from aqi: Int) -> UIColor {
        if (0...20).contains(aqi) {
            return .systemGreen
        } else if (21...40).contains(aqi) {
            return .systemYellow
        } else if (41...60).contains(aqi) {
            return .systemOrange
        } else if (61...80).contains(aqi) {
            return .systemRed
        } else if (81...90).contains(aqi) {
            return .systemPink
        } else if (91...100).contains(aqi) {
            return .systemPurple
        } else {
            return .white
        }
    }

    func getWeatherImage(from weatherCode: Int) -> UIImage {
        if (0...299).contains(weatherCode) {
            return UIImage(named: "thunder") ?? UIImage()
        }
        if (300...520).contains(weatherCode) || (522...620).contains(weatherCode) || weatherCode == 900 {
            return UIImage(named: "rain") ?? UIImage()
        }
        if weatherCode == 800 {
            return UIImage(named: "sun") ?? UIImage()
        }
        if (801...803).contains(weatherCode) {
            return UIImage(named: "sunAndClouds") ?? UIImage()
        }
        if weatherCode == 521 || weatherCode == 621 {
            return UIImage(named: "sunAndRain") ?? UIImage()
        }
        if (700...799).contains(weatherCode) || weatherCode == 804 {
            return UIImage(named: "cloudy") ?? UIImage()
        }
        
        return UIImage(named: "noWeather") ?? UIImage()
    }

}


// в документах к api сообщается, что оценка качетсва воздуха проходит по шкале от 0 до 500, но для "Дели, Индия" выдается показатель 67, что соответсвует показателю "удовлетворительно", а это один из городов с самым грязным воздухом. Поэтому новая шкала (не факт что соответсвует действительности". Но на всякий случай сохранил исходник ниже
/*
 func getAQIScore(from aqi: Int) -> String {
     if (0...50).contains(aqi) {
         return "Хорошо"
     } else if (51...100).contains(aqi) {
         return "Удовлетворительно"
     } else if (101...150).contains(aqi) {
         return "Плохо для чувствительных"
     } else if (151...200).contains(aqi) {
         return "Плохо"
     } else if (201...300).contains(aqi) {
         return "Очень плохо"
     } else if (301...500).contains(aqi) {
         return "Опасно"
     } else {
         return "Out of range"
     }
 }

 func getAQIDescription(from aqi: Int) -> String {
     if (0...50).contains(aqi) {
         return "Качество воздуха считается удовлетворительным, и загрязнение воздуха представляется незначительным в пределах нормы."
     } else if (51...100).contains(aqi) {
         return "Качество воздуха является приемлемым, однако некоторые загрязнители могут представлять опасность для людей, являющихся особо чувствительными к загрязнению воздуха."
     } else if (101...150).contains(aqi) {
         return "Может оказывать эффект на особо чувствительную группу лиц. На среднего представителя не оказывает видимого воздействия."
     } else if (151...200).contains(aqi) {
         return "Каждый может начать испытывать последствия для своего здоровья; особо чувствительные люди могут испытывать более серьезные последствия."
     } else if (201...300).contains(aqi) {
         return "Опасность для здоровья от чрезвычайных условий. Это отразится, вероятно, на всем населении."
     } else if (301...500).contains(aqi) {
         return "Опасность для здоровья: каждый человек может испытывать более серьезные последствия для здоровья."
     } else {
         return "Out of range"
     }
 }

 func getAQIColor(from aqi: Int) -> UIColor {
     if (0...50).contains(aqi) {
         return .systemGreen
     } else if (51...100).contains(aqi) {
         return .systemYellow
     } else if (101...150).contains(aqi) {
         return .systemOrange
     } else if (151...200).contains(aqi) {
         return .systemRed
     } else if (201...300).contains(aqi) {
         return .systemPurple
     } else if (301...500).contains(aqi) {
         return .systemBrown
     } else {
         return .white
     }
 }
 */
