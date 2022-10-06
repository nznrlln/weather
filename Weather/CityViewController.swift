//
//  CityViewController.swift
//  Weather
//
//  Created by Нияз Нуруллин on 18.12.2022.
//

import UIKit

class CityViewController: UIViewController {

    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.toAutoLayout()

        return scrollView
    }()

    private let contentView: UIView = {
        let view = UIView()
        view.toAutoLayout()

        return view
    }()

    private let dayView: DayWeatherView = {
        let view = DayWeatherView()
        view.toAutoLayout()
        view.backgroundColor = UIColor(named: "MainAccentColor")
        view.layer.cornerRadius = 5
        view.clipsToBounds = true

        return view
    }()

    private let dayHoursButton: UIButton = {
        let button = UIButton()
        button.toAutoLayout()
        button.setAttributedTitle(
            NSAttributedString(
                string: "Подробнее на 24 часа",
                attributes: [
                    NSAttributedString.Key.underlineStyle : NSUnderlineStyle.single.rawValue,
                    NSAttributedString.Key.font : UIFont(name: "Rubik-Regular", size: 16)!
                ]
            ),
            for: .normal
        )

        return button
    }()

    private lazy var dayHoursCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.toAutoLayout()

        collectionView.register(
            HourlyWeatherCollectionViewCell.self,
            forCellWithReuseIdentifier: HourlyWeatherCollectionViewCell.identifier
        )
        collectionView.dataSource = self
        collectionView.delegate = self

        return collectionView
    }()

    private let dailyLabel: UILabel = {
        let label = UILabel()
        label.toAutoLayout()
        label.text = "Ежедневный прогноз"
        label.font = UIFont(name: "Rubik-Medium", size: 18)

        return label
    }()

    private let numberOfDaysButton: UIButton = {
        let button = UIButton()
        button.toAutoLayout()
        button.setAttributedTitle(
            NSAttributedString(
                string: "25 дней",
                attributes: [
                    NSAttributedString.Key.underlineStyle : NSUnderlineStyle.single.rawValue,
                    NSAttributedString.Key.font : UIFont(name: "Rubik-Regular", size: 16)!
                ]
            ),
            for: .normal
        )

        return button
    }()

    private lazy var daysTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.toAutoLayout()
        tableView.backgroundColor = .systemBackground

        tableView.register(DateWeatherTableViewCell.self, forCellReuseIdentifier: DateWeatherTableViewCell.identifier)
        tableView.dataSource = self
        tableView.delegate = self

        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        viewInitialSettings()

    }

    private func viewInitialSettings() {
        view.backgroundColor = .white

        setupSubviews()
        setupSubviewsLayout()
    }

    private func setupSubviews() {
        contentView.addSubviews(
            dayView,
            dayHoursButton,
            dayHoursCollectionView,
            dailyLabel,
            numberOfDaysButton,
            daysTableView
        )

        scrollView.addSubview(contentView)
        view.addSubview(scrollView)

    }

    private func setupSubviewsLayout() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),

            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),

            dayView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 50),
            dayView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            dayView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),

            dayHoursButton.topAnchor.constraint(equalTo: dayView.bottomAnchor, constant: 33),
            dayHoursButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            dayHoursButton.heightAnchor.constraint(equalToConstant: 20),

            dayHoursCollectionView.topAnchor.constraint(equalTo: dayHoursButton.bottomAnchor, constant: 24),
            dayHoursCollectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            dayHoursCollectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            dayHoursCollectionView.heightAnchor.constraint(equalToConstant: 84),

            dailyLabel.topAnchor.constraint(equalTo: dayHoursCollectionView.bottomAnchor, constant: 24),
            dailyLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),

            numberOfDaysButton.topAnchor.constraint(equalTo: dayHoursCollectionView.bottomAnchor, constant: 27),
            numberOfDaysButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            numberOfDaysButton.heightAnchor.constraint(equalToConstant: 20),

            daysTableView.topAnchor.constraint(equalTo: dailyLabel.bottomAnchor, constant: 10),
            daysTableView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            daysTableView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            daysTableView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            daysTableView.heightAnchor.constraint(equalToConstant: 400)
        ])
    }


}


// MARK: - UICollectionViewDataSource

extension CityViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        10
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HourlyWeatherCollectionViewCell.identifier, for: indexPath) as! HourlyWeatherCollectionViewCell

        return cell
    }


}

// MARK: - UICollectionViewDelegateFlowLayout

extension CityViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 42, height: 84)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        16
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
}


// MARK: - UITableViewDataSource

extension CityViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        10
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DateWeatherTableViewCell.identifier, for: indexPath) as! DateWeatherTableViewCell

        return cell
    }


}

// MARK: - UITableViewDelegate

extension CityViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: .zero)
        return view
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        0
    }

    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = UIView(frame: .zero)
        return view
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        10
    }
}
