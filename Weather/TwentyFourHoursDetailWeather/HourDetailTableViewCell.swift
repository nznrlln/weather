//
//  HourDetailTableViewCell.swift
//  Weather
//
//  Created by Нияз Нуруллин on 05.01.2023.
//

import UIKit

class HourDetailTableViewCell: UITableViewCell {

    private let dateLabel: UILabel = {
        let label = UILabel()
        label.toAutoLayout()
        label.font = UIFont(name: "Rubik-Medium", size: 18)
        label.text = "Число"

        return label
    }()

    private let hourLabel: UILabel = {
        let label = UILabel()
        label.toAutoLayout()
        label.font = UIFont(name: "Rubik-Regular", size: 14)
        label.textColor = UIColor(named: "SecondaryTextColor")
        label.text = "Время"

        return label
    }()

    private let temperatureLabel: UILabel = {
        let label = UILabel()
        label.toAutoLayout()
        label.font = UIFont(name: "Rubik-Medium", size: 18)
        label.text = "7" + "º"

        return label
    }()

    private let moonImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.toAutoLayout()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "moon")

        return imageView
    }()

    private let predictedWeatherLabel: UILabel = {
        let label = UILabel()
        label.toAutoLayout()
        label.font = UIFont(name: "Rubik-Regular", size: 14)
        label.text = "Погода"
        label.lineBreakMode = .byTruncatingMiddle

        return label
    }()

    private let realFeelIndexLabel: UILabel = {
        let label = UILabel()
        label.toAutoLayout()
        label.font = UIFont(name: "Rubik-Regular", size: 14)
        label.textColor = UIColor(named: "SecondaryTextColor")
        label.text = "По ощущениям " + "7" + "º"

        return label
    }()

    private let windImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.toAutoLayout()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "wind")

        return imageView
    }()

    private let windLabel: UILabel = {
        let label = UILabel()
        label.toAutoLayout()
        label.font = UIFont(name: "Rubik-Regular", size: 14)
        label.text = "Ветер"

        return label
    }()

    private let windIndexLabel: UILabel = {
        let label = UILabel()
        label.toAutoLayout()
        label.font = UIFont(name: "Rubik-Regular", size: 14)
        label.textColor = UIColor(named: "SecondaryTextColor")
        label.text = "2" + " м/с" + " ССЗ"

        return label
    }()

    private let humidityImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.toAutoLayout()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "humidity")

        return imageView
    }()

    private let precipitationLabel: UILabel = {
        let label = UILabel()
        label.toAutoLayout()
        label.font = UIFont(name: "Rubik-Regular", size: 14)
        label.text = "Атмосферные осадки"

        return label
    }()

    private let precipitationIndexLabel: UILabel = {
        let label = UILabel()
        label.toAutoLayout()
        label.font = UIFont(name: "Rubik-Regular", size: 14)
        label.textColor = UIColor(named: "SecondaryTextColor")
        label.text = "0" + "%"

        return label
    }()

    private let cloudImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.toAutoLayout()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "cloudy")

        return imageView
    }()

    private let cloudLabel: UILabel = {
        let label = UILabel()
        label.toAutoLayout()
        label.font = UIFont(name: "Rubik-Regular", size: 14)
        label.text = "Облачность"

        return label
    }()

    private let cloudIndexLabel: UILabel = {
        let label = UILabel()
        label.toAutoLayout()
        label.font = UIFont(name: "Rubik-Regular", size: 14)
        label.textColor = UIColor(named: "SecondaryTextColor")
        label.text = "40" + "%"

        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        cellInitialSetting()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupCell(model: Forecast3hCoreData?) {
        guard let forecast = model else { preconditionFailure() }

//        "2023-01-17T04:00:00"
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        let date = dateFormatter.date(from: forecast.forecastTime ?? "2023-01-17T04:00:00")

        dateFormatter.dateFormat = "E dd/MM"
        dateLabel.text = dateFormatter.string(from: date ?? Date.distantPast)

        dateFormatter.dateFormat = FormatHelper.defaultHelper.getLocalizedHours()
        hourLabel.text = dateFormatter.string(from: date ?? Date.distantPast)
        temperatureLabel.text = "\(FormatHelper.defaultHelper.getLocalizedTemperature(from: forecast.temperature))"
        predictedWeatherLabel.text = forecast.weatherDescription
        realFeelIndexLabel.text = "По ощущениям " + "\(FormatHelper.defaultHelper.getLocalizedTemperature(from: forecast.feelsLikeTemperature))" 
        windIndexLabel.text = "\(FormatHelper.defaultHelper.getLocalizedVelocity(from: forecast.windVelocity)) \(forecast.windDirection ?? "")"
        precipitationIndexLabel.text = "\(forecast.precipitation)%"
        cloudIndexLabel.text = "\(forecast.cloudiness)%"
    }

    override func prepareForReuse() {
        dateLabel.text = ""
        hourLabel.text = ""
        temperatureLabel.text = ""
        predictedWeatherLabel.text = ""
        realFeelIndexLabel.text = ""
        windIndexLabel.text = ""
        precipitationIndexLabel.text = ""
        cloudIndexLabel.text = ""
    }

    private func cellInitialSetting() {
        self.backgroundColor = UIColor(named: "MainBackgroundColor")

        setupSubviews()
        setupSubviewsLayout()
    }
    private func setupSubviews() {
        contentView.addSubviews(dateLabel, hourLabel, temperatureLabel,
                                moonImageView, predictedWeatherLabel, realFeelIndexLabel,
                                windImageView, windLabel, windIndexLabel,
                                humidityImageView, precipitationLabel, precipitationIndexLabel,
                                cloudImageView, cloudLabel, cloudIndexLabel)
    }

    private func setupSubviewsLayout() {
        NSLayoutConstraint.activate([
            dateLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
            dateLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),

            hourLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 8),
            hourLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),

            temperatureLabel.topAnchor.constraint(equalTo: hourLabel.bottomAnchor, constant: 10),
            temperatureLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 22),

            moonImageView.centerYAnchor.constraint(equalTo: predictedWeatherLabel.centerYAnchor),
            moonImageView.leadingAnchor.constraint(equalTo: hourLabel.trailingAnchor, constant: 12),
            moonImageView.heightAnchor.constraint(equalToConstant: 12),
            moonImageView.widthAnchor.constraint(equalToConstant: 12),

            predictedWeatherLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 8),
            predictedWeatherLabel.leadingAnchor.constraint(equalTo: moonImageView.trailingAnchor, constant: 5),
            predictedWeatherLabel.widthAnchor.constraint(equalToConstant: 150),

            realFeelIndexLabel.centerYAnchor.constraint(equalTo: predictedWeatherLabel.centerYAnchor),
            realFeelIndexLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),

            windImageView.centerXAnchor.constraint(equalTo: moonImageView.centerXAnchor),
            windImageView.centerYAnchor.constraint(equalTo: windLabel.centerYAnchor),
            windImageView.heightAnchor.constraint(equalToConstant: 12),
            windImageView.widthAnchor.constraint(equalToConstant: 12),

            windLabel.topAnchor.constraint(equalTo: predictedWeatherLabel.bottomAnchor, constant: 8),
            windLabel.leadingAnchor.constraint(equalTo: predictedWeatherLabel.leadingAnchor),

            windIndexLabel.centerYAnchor.constraint(equalTo: windLabel.centerYAnchor),
            windIndexLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),

            humidityImageView.centerXAnchor.constraint(equalTo: moonImageView.centerXAnchor),
            humidityImageView.centerYAnchor.constraint(equalTo: precipitationLabel.centerYAnchor),
            humidityImageView.heightAnchor.constraint(equalToConstant: 12),
            humidityImageView.widthAnchor.constraint(equalToConstant: 12),

            precipitationLabel.topAnchor.constraint(equalTo: windLabel.bottomAnchor, constant: 8),
            precipitationLabel.leadingAnchor.constraint(equalTo: predictedWeatherLabel.leadingAnchor),

            precipitationIndexLabel.centerYAnchor.constraint(equalTo: precipitationLabel.centerYAnchor),
            precipitationIndexLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),

            cloudImageView.centerXAnchor.constraint(equalTo: moonImageView.centerXAnchor),
            cloudImageView.centerYAnchor.constraint(equalTo: cloudLabel.centerYAnchor),
            cloudImageView.heightAnchor.constraint(equalToConstant: 12),
            cloudImageView.widthAnchor.constraint(equalToConstant: 12),

            cloudLabel.topAnchor.constraint(equalTo: precipitationLabel.bottomAnchor, constant: 8),
            cloudLabel.leadingAnchor.constraint(equalTo: predictedWeatherLabel.leadingAnchor),
            cloudLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),

            cloudIndexLabel.centerYAnchor.constraint(equalTo: cloudLabel.centerYAnchor),
            cloudIndexLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),


        ])
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
