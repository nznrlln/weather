//
//  DateCollectionViewCell.swift
//  Weather
//
//  Created by Нияз Нуруллин on 16.02.2023.
//

import UIKit

class DateCollectionViewCell: UICollectionViewCell {
    var currentDate: String?

    private let dateLabel: UILabel = {
        let label = UILabel()
        label.toAutoLayout()
        label.font = UIFont(name: "Rubik-Regular", size: 18)
        label.text = "16/04 ПТ"
        label.textAlignment = .center

        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        cellInitialSetting()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupCell(date: String?) {
        guard let forecastDate = date else { preconditionFailure() }
        currentDate = forecastDate

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = dateFormatter.date(from: forecastDate)

        dateFormatter.dateFormat = "dd/MM E"
        dateLabel.text = dateFormatter.string(from: date ?? Date.distantPast)
    }

    override func prepareForReuse() {
        super.prepareForReuse()

        currentDate = nil
        dateLabel.text = ""
    }

    func setSelectedState() {
        self.backgroundColor = UIColor(named: "MainAccentColor")
        dateLabel.textColor = .white
    }

    func setDeselectedState() {
        self.backgroundColor = UIColor(named: "MainBackgroundColor")
        dateLabel.textColor = .black
    }

    private func cellInitialSetting() {
        self.backgroundColor = UIColor(named: "MainBackgroundColor")
        self.layer.cornerRadius = 5
        self.layer.borderWidth = 0.5
        self.layer.borderColor = UIColor(named: "BorderColor")?.cgColor
        self.clipsToBounds = true

        setupSubviews()
        setupSubviewsLayout()
    }

    private func setupSubviews() {
        contentView.addSubviews(dateLabel)
    }

    private func setupSubviewsLayout() {
        NSLayoutConstraint.activate([
            dateLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 7),
            dateLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 7),
            dateLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -7),
            dateLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -7)
        ])
    }
}
