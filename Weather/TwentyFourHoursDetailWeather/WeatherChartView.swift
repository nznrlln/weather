//
//  WeatherChartView.swift
//  Weather
//
//  Created by Нияз Нуруллин on 20.02.2023.
//

import UIKit
import Charts

class WeatherChartView: UIView {

    private let temperatureLineChart: LineChartView = {
        let chartView = LineChartView()
        chartView.toAutoLayout()
        chartView.backgroundColor = UIColor(named: "MainBackgroundColor")

        chartView.leftAxis.enabled = false
        chartView.rightAxis.enabled = false
        chartView.xAxis.enabled = false
        chartView.extraTopOffset = 20
        chartView.animate(xAxisDuration: 1)

        return chartView
    }()

    private let humidityLineChart: LineChartView = {
        let chartView = LineChartView()
        chartView.toAutoLayout()
        chartView.backgroundColor = UIColor(named: "MainBackgroundColor")

        chartView.leftAxis.enabled = false
        chartView.rightAxis.enabled = false
        chartView.xAxis.enabled = false
        chartView.extraTopOffset = 20
        chartView.animate(xAxisDuration: 1)

        return chartView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        viewInitialSettings()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setChartData(forecast: [Forecast3hCoreData]?) {
        guard let forecast = forecast else { return }

        var tempLabel: String = ""
        switch UserDefaultSettings.temperatureUnit {
        case .celsius:
            tempLabel = "Температура, ℃"
        case .fahrenheit:
            tempLabel = "Температура, ℉"
        }
        let temperatureSet = LineChartDataSet(entries: getTemperatureValues(forecast: forecast), label: tempLabel)
        temperatureSet.mode = .cubicBezier
        temperatureSet.lineWidth = 2
        temperatureSet.setColor(.systemRed)
        temperatureSet.circleRadius = 6
        temperatureSet.setCircleColor(.white)
        temperatureSet.circleHoleColor  = .systemRed
        temperatureSet.valueFont = UIFont(name: "Rubik-Regular", size: 10) ?? .systemFont(ofSize: 10)

        let tempGradientColors = [UIColor.systemRed.cgColor, UIColor.clear.cgColor] as CFArray
        let tempColorLocations:[CGFloat] = [0.6, 0.0]
        let tempGradient = CGGradient.init(colorsSpace: CGColorSpaceCreateDeviceRGB(), colors: tempGradientColors, locations: tempColorLocations)
        temperatureSet.fill = LinearGradientFill(gradient: tempGradient!, angle: 90)
        temperatureSet.drawFilledEnabled = true


        let humiditySet = LineChartDataSet(entries: getHumidityValues(forecast: forecast), label: "Влажность, %")
        humiditySet.mode = .cubicBezier
        humiditySet.lineWidth = 2
        humiditySet.setColor(.systemIndigo)
        humiditySet.circleRadius = 6
        humiditySet.setCircleColor(.white)
        humiditySet.circleHoleColor  = .systemIndigo
        humiditySet.valueFont = UIFont(name: "Rubik-Regular", size: 10) ?? .systemFont(ofSize: 10)

        let humGradientColors = [UIColor.systemIndigo.cgColor, UIColor.clear.cgColor] as CFArray
        let humColorLocations:[CGFloat] = [0.6, 0.0]
        let humGradient = CGGradient.init(colorsSpace: CGColorSpaceCreateDeviceRGB(), colors: humGradientColors, locations: humColorLocations)
        humiditySet.fill = LinearGradientFill(gradient: humGradient!, angle: 90)
        humiditySet.drawFilledEnabled = true

        temperatureLineChart.data = LineChartData(dataSet: temperatureSet)
        humidityLineChart.data = LineChartData(dataSet: humiditySet)

        temperatureLineChart.notifyDataSetChanged()
        humidityLineChart.notifyDataSetChanged()

        temperatureLineChart.sizeToFit()
        humidityLineChart.sizeToFit()
    }

    private func viewInitialSettings() {
        self.addSubviews(temperatureLineChart, humidityLineChart)

        NSLayoutConstraint.activate([
            temperatureLineChart.topAnchor.constraint(equalTo: self.topAnchor),
            temperatureLineChart.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            temperatureLineChart.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            temperatureLineChart.bottomAnchor.constraint(equalTo: self.centerYAnchor),

            humidityLineChart.topAnchor.constraint(equalTo: temperatureLineChart.bottomAnchor),
            humidityLineChart.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            humidityLineChart.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            humidityLineChart.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ])
    }


    private func getTemperatureValues(forecast: [Forecast3hCoreData]) -> [ChartDataEntry] {
        var valuesArray: [ChartDataEntry] = []
        for index in 0...7 {
            var temperature = Double(forecast[index].temperature)
            if UserDefaultSettings.temperatureUnit == .fahrenheit {
                temperature = Double(forecast[index].temperature) * 1.8 + 32
            }
            let entry = ChartDataEntry(x: Double(index), y: temperature)
            valuesArray.append(entry)
        }

        return valuesArray
    }

    private func getHumidityValues(forecast: [Forecast3hCoreData]) -> [ChartDataEntry] {
        var valuesArray: [ChartDataEntry] = []

        for index in 0...7 {
            let entry = ChartDataEntry(x: Double(index), y: Double(forecast[index].humidityLevel))
            valuesArray.append(entry)
        }

        return valuesArray
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
