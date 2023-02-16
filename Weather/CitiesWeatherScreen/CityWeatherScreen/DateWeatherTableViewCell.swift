//
//  DateWeatherTableViewCell.swift
//  Weather
//
//  Created by Нияз Нуруллин on 02.01.2023.
//

import UIKit

class DateWeatherTableViewCell: UITableViewCell {

    private let dateLabel: UILabel = {
        let label = UILabel()
        label.toAutoLayout()
        label.font = UIFont(name: "Rubik-Regular", size: 16)
        label.textColor = UIColor(named: "SecondaryTextColor")
        label.text = "17/04"


        return label
    }()

    private let weatherImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.toAutoLayout()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "cloud2")

        return imageView
    }()

    private let humidityLabel: UILabel = {
        let label = UILabel()
        label.toAutoLayout()
        label.font = UIFont(name: "Rubik-Regular", size: 12)
        label.textColor = UIColor(named: "CustomBlue")
        label.text = "75" + "%"

        return label
    }()

    private let currentWeatherLabel: UILabel = {
        let label = UILabel()
        label.toAutoLayout()
        label.font = UIFont(name: "Rubik-Regular", size: 16)
        label.text = "Возможен небольшой дождь"
        label.lineBreakMode = .byTruncatingMiddle

        return label
    }()

    private let tempRangeLabel: UILabel = {
        let label = UILabel()
        label.toAutoLayout()
        label.font = UIFont(name: "Rubik-Regular", size: 18)
        label.text = "7" + "º" + "-" + "13" + "º"

        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        cellInitialSetting()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupCell(model: Forecast1dCoreData?) {
        guard let forecast = model else { preconditionFailure() }

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = dateFormatter.date(from: forecast.forecastDate ?? "2023-01-17")

        dateFormatter.dateFormat = "dd/MM"
        dateLabel.text = dateFormatter.string(from: date ?? Date.distantPast)
        weatherImageView.image = CoreDataHelper.defaultHelper.getWeatherImage(from: Int(forecast.weatherCode))
        humidityLabel.text = "\(forecast.humidityLevel) %"
        currentWeatherLabel.text = forecast.weatherDescription
        tempRangeLabel.text = "\(forecast.temperatureMin)º/\(forecast.temperatureMax)º"
    }

    override func prepareForReuse() {
        super.prepareForReuse()

        dateLabel.text = ""
        weatherImageView.image = nil
        humidityLabel.text = ""
        currentWeatherLabel.text = ""
        tempRangeLabel.text = ""
    }

    private func cellInitialSetting() {
        self.backgroundColor = UIColor(named: "MainBackgroundColor")
        self.layer.cornerRadius = 5
        self.clipsToBounds = true
        self.accessoryType = .disclosureIndicator

        setupSubviews()
        setupSubviewsLayout()
    }
    private func setupSubviews() {
        contentView.addSubviews(dateLabel, weatherImageView, humidityLabel, currentWeatherLabel, tempRangeLabel)
    }

    private func setupSubviewsLayout() {
        NSLayoutConstraint.activate([
            dateLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 6),
            dateLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),

            weatherImageView.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 5),
            weatherImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
//            weatherImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            weatherImageView.heightAnchor.constraint(equalToConstant: 18),
            weatherImageView.widthAnchor.constraint(equalToConstant: 15),

            humidityLabel.centerYAnchor.constraint(equalTo: weatherImageView.centerYAnchor),
            humidityLabel.leadingAnchor.constraint(equalTo: weatherImageView.trailingAnchor, constant: 5),

            currentWeatherLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 19),
            currentWeatherLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 66),
            currentWeatherLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -60),
            currentWeatherLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -18),

            tempRangeLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 17),
            tempRangeLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),

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
