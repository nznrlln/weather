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

    func setupCell() {
    }

    override func prepareForReuse() {
        super.prepareForReuse()

        weatherImageView.image = nil
    }

    private func cellInitialSetting() {
//        self.contentView.backgroundColor = .blue

        setupSubviews()
        setupSubviewsLayout()
    }

    private func setupSubviews() {
        contentView.layer.cornerRadius = 22
        contentView.layer.borderWidth = 0.5
        contentView.layer.borderColor = UIColor(named: "BorderColor")?.cgColor
        contentView.clipsToBounds = true


        contentView.addSubviews(hourLabel, weatherImageView, temperatureLabel)
    }

    private func setupSubviewsLayout() {
        NSLayoutConstraint.activate([

            hourLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
            hourLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),

            weatherImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 37),
            weatherImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 13),
            weatherImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -13),
            weatherImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,constant: -31),

            temperatureLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor, constant: 2),
            temperatureLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
    }

    

}
