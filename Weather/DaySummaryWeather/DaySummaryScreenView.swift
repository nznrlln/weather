//
//  DaySummaryScreenView.swift
//  Weather
//
//  Created by Нияз Нуруллин on 16.02.2023.
//

import UIKit

protocol DaySummaryScreenViewDelegate {
    var cityLabel: String? { get }
    var currentForecast: Forecast1dCoreData? { get }
    var currentWeather: CurrentWeatherCoreData? { get }
    var dates: [String]? { get }

    func didSelectCellAction(newDate: String, completion: () -> Void)
}

class DaySummaryScreenView: UIView {

    var delegate: DaySummaryScreenViewDelegate?

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
        collectionView.showsHorizontalScrollIndicator = false

        collectionView.register(DateCollectionViewCell.self, forCellWithReuseIdentifier: DateCollectionViewCell.identifier)
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

    private let moonStateLabel: UILabel = {
        let label = UILabel()
        label.toAutoLayout()
        label.font = UIFont(name: "Rubik-Regular", size: 14)

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

    private let airQualityDescriptionLabel: UILabel = {
        let label = UILabel()
        label.toAutoLayout()
        label.font = UIFont(name: "Rubik-Regular", size: 14)
        label.textColor = UIColor(named: "SecondaryTextColor")
        label.numberOfLines = 0
//        label.textAlignment = .left
        label.text = "Качество воздуха считается удовлетворительным и загрязнения воздуха представляются незначительными в пределах нормы"

        return label
    }()

    init() {
        super.init(frame: .zero)
        viewInitialSettings()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupView() {
        cityLabel.text = delegate?.cityLabel ?? ""
        moonStateLabel.text = CoreDataHelper.defaultHelper.getMoonphaseText(from: delegate?.currentForecast?.moonphase ?? 0)
        sunInfoView.setupView(model: delegate?.currentForecast)
        moonInfoView.setupView(model: delegate?.currentForecast)

        if let aqi = delegate?.currentWeather?.airQualityIndex {
            airQualityIndex.text = "\(aqi)"
            airQualityLabel.text = CoreDataHelper.defaultHelper.getAQIScore(from: Int(aqi))
            airQualityLabel.backgroundColor = CoreDataHelper.defaultHelper.getAQIColor(from: Int(aqi))
            airQualityDescriptionLabel.text = CoreDataHelper.defaultHelper.getAQIDescription(from: Int(aqi))
        }
    }

    private func viewInitialSettings() {
        self.backgroundColor = .white

        setupSubviews()
        setupSubviewsLayout()
    }

    private func setupSubviews() {
        contentView.addSubviews(cityLabel,
                               daysCollectionView,
                               dayNightTableView,
                               sunMoonLable, moonStateLabel, sunInfoView, separatorLineView, moonInfoView,
                               airQualityHeader, airQualityIndex, airQualityLabel, airQualityDescriptionLabel)

        scrollView.addSubview(contentView)
        self.addSubview(scrollView)
    }

    private func setupSubviewsLayout() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: self.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: self.bottomAnchor),

            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),

            cityLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
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

            moonStateLabel.centerYAnchor.constraint(equalTo: sunMoonLable.centerYAnchor),
            moonStateLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),

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

            airQualityDescriptionLabel.topAnchor.constraint(equalTo: airQualityLabel.bottomAnchor, constant: 10),
            airQualityDescriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            airQualityDescriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            airQualityDescriptionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -23),
//            airQualityInfoLabel.heightAnchor.constraint(equalToConstant: 76)

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





// MARK: - UICollectionViewDataSource

extension DaySummaryScreenView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let dates = delegate?.dates {
            return dates.count
        }

        return 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DateCollectionViewCell.identifier, for: indexPath) as! DateCollectionViewCell
        if let dates = delegate?.dates {
            cell.setupCell(date: dates[indexPath.row])
        }

        return cell
    }

}

// MARK: - UICollectionViewDelegateFlowLayout

extension DaySummaryScreenView: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 96, height: 36)
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

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! DateCollectionViewCell
        guard let date = cell.currentDate else { return }
        delegate?.didSelectCellAction(newDate: date) {
            self.setupView()
            self.dayNightTableView.reloadData()
            cell.setSelectedState()
        }
    }

    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? DateCollectionViewCell else { return }
        cell.setDeselectedState()
    }
    
}


// MARK: - UITableViewDataSource

extension DaySummaryScreenView: UITableViewDataSource {
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
                if let temp = delegate?.currentForecast?.feelsLikeTemperatureMax{
                    cell.setupCell("thermometer", "По ощущениям", "\(FormatHelper.defaultHelper.getLocalizedTemperature(from: temp))")
                }
            } else if indexPath.row == 1 {
                if let velocity = delegate?.currentForecast?.windVelocity,
                   let direction = delegate?.currentForecast?.windDirection {
                    cell.setupCell("wind", "Ветер", "\(FormatHelper.defaultHelper.getLocalizedVelocity(from: velocity)) \(direction)")
                }
            } else if indexPath.row == 2 {
                if let uv = delegate?.currentForecast?.uvIndex {
                    cell.setupCell("sun", "Уф индекс", "\(uv)")
                }
            } else if indexPath.row == 3 {
                if let rain = delegate?.currentForecast?.precipitation {
                    cell.setupCell("rain", "Дождь", "\(rain)%")
                }
            } else if indexPath.row == 4 {
                if let cloudiness = delegate?.currentForecast?.cloudiness {
                    cell.setupCell("cloudy", "Облачность", "\(cloudiness)%")
                }
            }
        } else if indexPath.section == 1 {
            if indexPath.row == 0 {
                if let temp = delegate?.currentForecast?.feelsLikeTemperatureMin{
                    cell.setupCell("thermometer", "По ощущениям", "\(FormatHelper.defaultHelper.getLocalizedTemperature(from: temp))")
                }
            } else if indexPath.row == 1 {
                if let velocity = delegate?.currentForecast?.windVelocity,
                   let direction = delegate?.currentForecast?.windDirection {
                    cell.setupCell("wind", "Ветер", "\(FormatHelper.defaultHelper.getLocalizedVelocity(from: velocity)) \(direction)")
                }
            } else if indexPath.row == 2 {
                if let uv = delegate?.currentForecast?.uvIndex {
                    cell.setupCell("sun", "Уф индекс", "\(uv)")
                }
            } else if indexPath.row == 3 {
                if let rain = delegate?.currentForecast?.precipitation {
                    cell.setupCell("rain", "Дождь", "\(rain)%")
                }
            } else if indexPath.row == 4 {
                if let cloudiness = delegate?.currentForecast?.cloudiness {
                    cell.setupCell("cloudy", "Облачность", "\(cloudiness)%")
                }
            }
        }
        return cell
    }


}

// MARK: - UITableViewDelegate

extension DaySummaryScreenView: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        46
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            let headerView = DayNightTableHeaderView(frame: .zero, dayState: .day)
            headerView.setupView(model: delegate?.currentForecast)

            return headerView
        } else {
            let headerView = DayNightTableHeaderView(frame: .zero, dayState: .night)
            headerView.setupView(model: delegate?.currentForecast)
            
            return headerView
        }
    }

}
