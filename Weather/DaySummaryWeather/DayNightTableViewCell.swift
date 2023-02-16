//
//  DayNightTableViewCell.swift
//  Weather
//
//  Created by Нияз Нуруллин on 07.01.2023.
//

import UIKit

class DayNightTableViewCell: UITableViewCell {

    private let infoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.toAutoLayout()
        imageView.contentMode = .scaleAspectFit

        return imageView
    }()

    private let infoLabel: UILabel = {
        let label = UILabel()
        label.toAutoLayout()
        label.font = UIFont(name: "Rubik-Regular", size: 14)

        return label
    }()

    private let infoDataLabel: UILabel = {
        let label = UILabel()
        label.toAutoLayout()
        label.font = UIFont(name: "Rubik-Regular", size: 18)

        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        cellInitialSetting()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func cellInitialSetting() {
        contentView.backgroundColor = UIColor(named: "MainBackgroundColor")

        setupSubviews()
        setupSubviewsLayout()
    }

    private func setupSubviews() {
        contentView.addSubviews(infoImageView, infoLabel, infoDataLabel)
    }

    private func setupSubviewsLayout() {
        NSLayoutConstraint.activate([
            infoImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            infoImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            infoImageView.heightAnchor.constraint(equalToConstant: 30),
            infoImageView.widthAnchor.constraint(equalToConstant: 30),

            infoLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            infoLabel.leadingAnchor.constraint(equalTo: infoImageView.trailingAnchor, constant: 15),

            infoDataLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            infoDataLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
        ])
    }

    func setupCell(_ imageName: String, _ info: String, _ infoData: String) {
        infoImageView.image = UIImage(named: imageName)
        infoLabel.text = info
        infoDataLabel.text = infoData
    }

    override func prepareForReuse() {
        super.prepareForReuse()

        infoImageView.image = UIImage()
        infoLabel.text = ""
        infoDataLabel.text = ""
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        self.backgroundColor = UIColor(named: "CustomBlue")
    }

}
