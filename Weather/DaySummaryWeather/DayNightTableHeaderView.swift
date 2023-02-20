//
//  DayNightTableHeaderView.swift
//  Weather
//
//  Created by Нияз Нуруллин on 07.01.2023.
//

import UIKit

enum DayState {
    case day
    case night
}

class DayNightTableHeaderView: UIView {

    private let dayState: DayState!

    private lazy var dayNightLable: UILabel = {
        let label = UILabel()
        label.toAutoLayout()
        label.font = UIFont(name: "Rubik-Regular", size: 18)

        switch dayState {
        case .day:
            label.text = "День"
        case .night:
            label.text = "Ночь"
        case .none:
            label.text = "error"
        }

        return label
    }()

    private let weatherImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.toAutoLayout()
        imageView.contentMode = .scaleAspectFit

        return imageView
    }()

    private let temperatureLabel: UILabel = {
        let label = UILabel()
        label.toAutoLayout()
        label.font = UIFont(name: "Rubik-Regular", size: 30)
        label.text = "7" + "º"

        return label
    }()

    private let stackView: UIStackView = {
        let view = UIStackView()
        view.toAutoLayout()

        return view
    }()

    private let weatherLabel: UILabel = {
        let label = UILabel()
        label.toAutoLayout()
        label.font = UIFont(name: "Rubik-Medium", size: 18)

        return label
    }()

    init(frame: CGRect, dayState: DayState) {
        self.dayState = dayState
        super.init(frame: frame)

        viewInitialSettings()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupView(model: Forecast1dCoreData?) {
        guard let forecast = model else { preconditionFailure() }

        weatherImageView.image = CoreDataHelper.defaultHelper.getWeatherImage(from: Int(forecast.weatherCode))
        weatherLabel.text = "\(forecast.weatherDescription ?? "")"
        if dayState == .day {
            temperatureLabel.text = "\(forecast.temperatureMax)"
        } else {
            temperatureLabel.text = "\(forecast.temperatureMin)"
        }
    }

    private func viewInitialSettings() {
        self.backgroundColor = UIColor(named: "MainBackgroundColor")

        setupSubviews()
        setupSubviewsLayout()
    }

    private func setupSubviews() {
        stackView.addArrangedSubview(weatherImageView)
        stackView.addArrangedSubview(temperatureLabel)

        self.addSubviews(dayNightLable, stackView, weatherLabel)
    }

    private func setupSubviewsLayout() {
        NSLayoutConstraint.activate([
            dayNightLable.topAnchor.constraint(equalTo: self.topAnchor, constant: 21),
            dayNightLable.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15),

            stackView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            stackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 15),
            stackView.heightAnchor.constraint(equalToConstant: 37),
            stackView.widthAnchor.constraint(equalToConstant: 72),

            weatherLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            weatherLabel.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 10),
            weatherLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -15),
        ])
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
