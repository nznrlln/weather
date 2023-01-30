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
        dateFormatter.dateFormat = "HH:mm"
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

    func getWeatherImage(from weatherCode: Int) -> UIImage {
        if (0...299).contains(weatherCode) {
            return UIImage(named: "thunder") ?? UIImage()
        }
//        else if (300...520, 522...620).con
//        if weatherCode > 900 {
//            return UIImage()
//        }
        return UIImage()
    }

}
