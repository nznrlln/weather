//
//  24hoursForcastViewController.swift
//  Weather
//
//  Created by Нияз Нуруллин on 11.12.2022.
//

import UIKit

class DaySummaryWeatherViewController: UIViewController {

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

    private let cityLabel: UILabel = {
        let label = UILabel()
        label.toAutoLayout()
        label.font = UIFont(name: "Rubik-Medium", size: 18)
        label.text = "Текущий город"

        return label
    }()

    private lazy var daysCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.toAutoLayout()

        collectionView.register(
            UICollectionViewCell.self,
            forCellWithReuseIdentifier: UICollectionViewCell.identifier
        )
        collectionView.dataSource = self
        collectionView.delegate = self

        return collectionView
    }()

    private lazy var dayNightTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.toAutoLayout()
        tableView.isScrollEnabled = false
//        tableView.layer.cornerRadius = 5
//        tableView.clipsToBounds = true
        tableView.backgroundColor = .white
        tableView.separatorColor = UIColor(named: "CustomBlue")

        tableView.register(DayNightTableViewCell.self, forCellReuseIdentifier: DayNightTableViewCell.identifier)
        tableView.dataSource = self
        tableView.delegate = self

        return tableView
    }()

    private let sunMoonLable: UILabel = {
        let label = UILabel()
        label.toAutoLayout()
        label.font = UIFont(name: "Rubik-Medium", size: 18)
        label.text = "Солнце и Луна"

        return label
    }()

    private let sunInfoView: SunMoonView = {
        let view = SunMoonView(frame: .zero, viewState: .sun)
        view.toAutoLayout()

        return view
    }()

    private let separatorLineView: UIView = {
        let view = UIView()
        view.toAutoLayout()
        view.backgroundColor = UIColor(named: "CustomBlue")

        return view
    }()

    private let moonInfoView: SunMoonView = {
        let view = SunMoonView(frame: .zero, viewState: .moon)
        view.toAutoLayout()

        return view
    }()

    private let airQualityHeader: UILabel = {
        let label = UILabel()
        label.toAutoLayout()
        label.font = UIFont(name: "Rubik-Medium", size: 18)
        label.text = "Качество воздуха"

        return label
    }()

    private let airQualityIndex: UILabel = {
        let label = UILabel()
        label.toAutoLayout()
        label.font = UIFont(name: "Rubik-Regular", size: 30)
        label.text = "AQI"

        return label
    }()

    private let airQualityLabel: UILabel = {
        let label = UILabel()
        label.toAutoLayout()
        label.layer.cornerRadius = 5
        label.clipsToBounds = true
        label.backgroundColor = UIColor(named: "CustomGreen")

        label.font = UIFont(name: "Rubik-Regular", size: 16)
        label.textColor = .white
        label.text = "Качество воздуха"

        return label
    }()

    private let airQualityInfoLabel: UILabel = {
        let label = UILabel()
        label.toAutoLayout()
        label.font = UIFont(name: "Rubik-Regular", size: 14)
        label.textColor = UIColor(named: "SecondaryTextColor")
        label.numberOfLines = 0
//        label.textAlignment = .left
        label.text = "Качество воздуха считается удовлетворительным и загрязнения воздуха представляются незначительными в пределах нормы"

        return label
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
        contentView.addSubviews(cityLabel,
                               daysCollectionView,
                               dayNightTableView,
                               sunMoonLable, sunInfoView, separatorLineView, moonInfoView,
                               airQualityHeader, airQualityIndex, airQualityLabel, airQualityInfoLabel)

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

            cityLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 65),
            cityLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),

            daysCollectionView.topAnchor.constraint(equalTo: cityLabel.bottomAnchor, constant: 40),
            daysCollectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            daysCollectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            daysCollectionView.heightAnchor.constraint(equalToConstant: 36),

            dayNightTableView.topAnchor.constraint(equalTo: daysCollectionView.bottomAnchor, constant: 40),
            dayNightTableView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            dayNightTableView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            dayNightTableView.heightAnchor.constraint(equalToConstant: 694),

            sunMoonLable.topAnchor.constraint(equalTo: dayNightTableView.bottomAnchor, constant: 20),
            sunMoonLable.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),

            sunInfoView.topAnchor.constraint(equalTo: sunMoonLable.bottomAnchor, constant: 17),
            sunInfoView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            sunInfoView.heightAnchor.constraint(equalToConstant: 96),
            sunInfoView.widthAnchor.constraint(equalToConstant: 160),

            separatorLineView.topAnchor.constraint(equalTo: sunInfoView.topAnchor),
            separatorLineView.leadingAnchor.constraint(equalTo: sunInfoView.trailingAnchor, constant: 12),
            separatorLineView.heightAnchor.constraint(equalToConstant: 96),
            separatorLineView.widthAnchor.constraint(equalToConstant: 1),

            moonInfoView.topAnchor.constraint(equalTo: sunMoonLable.bottomAnchor, constant: 17),
            moonInfoView.leadingAnchor.constraint(equalTo: separatorLineView.trailingAnchor, constant: 12),
            moonInfoView.heightAnchor.constraint(equalToConstant: 96),
            moonInfoView.widthAnchor.constraint(equalToConstant: 160),

            airQualityHeader.topAnchor.constraint(equalTo: sunMoonLable.bottomAnchor, constant: 139),
            airQualityHeader.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            airQualityHeader.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),

            airQualityIndex.topAnchor.constraint(equalTo: airQualityHeader.bottomAnchor, constant: 10),
            airQualityIndex.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),

            airQualityLabel.topAnchor.constraint(equalTo: airQualityHeader.bottomAnchor, constant: 10),
            airQualityLabel.leadingAnchor.constraint(equalTo: airQualityIndex.trailingAnchor, constant: 15),
            airQualityLabel.heightAnchor.constraint(equalTo: airQualityIndex.heightAnchor),

            airQualityInfoLabel.topAnchor.constraint(equalTo: airQualityLabel.bottomAnchor, constant: 10),
            airQualityInfoLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            airQualityInfoLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            airQualityInfoLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -23),
//            airQualityInfoLabel.heightAnchor.constraint(equalToConstant: 76)

        ])
    }


}





// MARK: - UICollectionViewDataSource

extension DaySummaryWeatherViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        10
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: UICollectionViewCell.identifier, for: indexPath)
        cell.layer.cornerRadius = 5
        cell.backgroundColor = UIColor(named: "CustomBlue")

        return cell
    }


}

// MARK: - UICollectionViewDelegateFlowLayout

extension DaySummaryWeatherViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 88, height: 36)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        18
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 0,
                     left: 0,
                     bottom: 0,
                     right: 0)
    }
}


// MARK: - UITableViewDataSource

extension DaySummaryWeatherViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        5
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DayNightTableViewCell.identifier, for: indexPath) as! DayNightTableViewCell

        if indexPath.section == 0 {
            if indexPath.row == 0 {
                cell.setupCell("thermometer", "По ощущениям", "?")
            } else if indexPath.row == 1 {
                cell.setupCell("wind", "Ветер", "?")
            } else if indexPath.row == 2 {
                cell.setupCell("sun", "Уф индекс", "?")
            } else if indexPath.row == 3 {
                cell.setupCell("rain", "Дождь", "?")
            } else if indexPath.row == 4 {
                cell.setupCell("cloudy", "Облачность", "?")
            }
        } else if indexPath.section == 1 {
            if indexPath.row == 0 {
                cell.setupCell("thermometer", "По ощущениям", "+")
            } else if indexPath.row == 1 {
                cell.setupCell("wind", "Ветер", "+")
            } else if indexPath.row == 2 {
                cell.setupCell("sun", "Уф индекс", "+")
            } else if indexPath.row == 3 {
                cell.setupCell("rain", "Дождь", "+")
            } else if indexPath.row == 4 {
                cell.setupCell("cloudy", "Облачность", "+")
            }
        }
        return cell
    }


}

// MARK: - UITableViewDelegate

extension DaySummaryWeatherViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        46
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            let headerView = DayNightTableHeaderView(frame: .zero, dayState: .day)
            return headerView
        } else {
            let headerView = DayNightTableHeaderView(frame: .zero, dayState: .night)
            return headerView
        }
    }

//    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
//        let footerView = UIView()
//        footerView.backgroundColor = UIColor(named: "MainBackgroundColor")
//
//        return footerView
//    }
//
//    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
//        10
//    }

    
}
