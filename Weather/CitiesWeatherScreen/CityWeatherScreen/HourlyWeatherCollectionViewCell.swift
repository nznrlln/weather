//
//  HourlyWeatherCollectionViewCell.swift
//  Weather
//
//  Created by Нияз Нуруллин on 25.12.2022.
//

import UIKit

class HourlyWeatherCollectionViewCell: UICollectionViewCell {

    private let hourLabel: UILabel = {
        let label = UILabel()
        label.toAutoLayout()
        label.font = UIFont(name: "Rubik-Regular", size: 14)
        label.lineBreakMode = .byCharWrapping
        label.text = "12:00"

        return label
    }()

    private let weatherImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.toAutoLayout()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "cloud2")

        return imageView
    }()

    private let temperatureLabel: UILabel = {
        let label = UILabel()
        label.toAutoLayout()
        label.font = UIFont(name: "Rubik-Regular", size: 16)
        label.text = "13" + "º"

        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        cellInitialSetting()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupCell(model: Forecast3hCoreData?) {
        guard let forecast = model else { preconditionFailure() }

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        let date = dateFormatter.date(from: forecast.forecastTime ?? "2023-01-17T04:00:00")

        dateFormatter.dateFormat = FormatHelper.defaultHelper.getLocalizedHours()
        hourLabel.text = dateFormatter.string(from: date ?? Date.distantPast)
        weatherImageView.image = CoreDataHelper.defaultHelper.getWeatherImage(from: Int(forecast.weatherCode))
        temperatureLabel.text = "\(FormatHelper.defaultHelper.getLocalizedTemperature(from: forecast.temperature))" 
    }

    override func prepareForReuse() {
        super.prepareForReuse()

        hourLabel.text = ""
        weatherImageView.image = nil
        temperatureLabel.text = ""
    }

    func setHighlightedState() {
        self.backgroundColor = UIColor(named: "MainAccentColor")
        hourLabel.textColor = .white
        temperatureLabel.textColor = .white
    }

    func setDeselectedState() {
        self.backgroundColor = .white
        hourLabel.textColor = .black
        temperatureLabel.textColor = .black
    }

    private func cellInitialSetting() {
        setupSubviews()
        setupSubviewsLayout()
    }

    private func setupSubviews() {
        self.layer.cornerRadius = 22
        self.layer.borderWidth = 0.5
        self.layer.borderColor = UIColor(named: "BorderColor")?.cgColor
        self.clipsToBounds = true

        contentView.addSubviews(hourLabel, weatherImageView, temperatureLabel)
    }

    private func setupSubviewsLayout() {
        NSLayoutConstraint.activate([
            hourLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
            hourLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            hourLabel.widthAnchor.constraint(equalToConstant: 38),

            weatherImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 37),
            weatherImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 13),
            weatherImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -13),
            weatherImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,constant: -31),

            temperatureLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor, constant: 0),
            temperatureLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
    }

    

}
