//
//  TwentyFourScreenView.swift
//  Weather
//
//  Created by Нияз Нуруллин on 29.01.2023.
//

import UIKit
import CoreData

protocol TwentyFourScreenViewDelegate {
    var cityLabel: String? { get }
    var forecast: [Forecast3hCoreData]? { get }
}

class TwentyFourScreenView: UIView {

    var delegate: TwentyFourScreenViewDelegate?

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

    private let weatherChart: WeatherChartView = {
        let view = WeatherChartView()
        view.toAutoLayout()
        view.backgroundColor = UIColor(named: "MainBackgroundColor")

        return view
    }()

    private lazy var hourlyTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.toAutoLayout()
        tableView.backgroundColor = .systemBackground
        tableView.separatorColor = UIColor(named: "CustomBlue")
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)

        tableView.register(HourDetailTableViewCell.self, forCellReuseIdentifier: HourDetailTableViewCell.identifier)
        tableView.dataSource = self
        tableView.delegate = self

        return tableView
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
        weatherChart.setChartData(forecast: delegate?.forecast)
    }

    private func viewInitialSettings() {
        self.backgroundColor = .white

        setupSubviews()
        setupSubviewsLayout()
    }

    private func setupSubviews() {
        contentView.addSubviews(cityLabel, weatherChart, hourlyTableView)
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

            cityLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: TwentyFourALConstants.labelTopInset),
            cityLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: TwentyFourALConstants.labelLeadingInset),

            weatherChart.topAnchor.constraint(equalTo: cityLabel.bottomAnchor, constant: TwentyFourALConstants.weatherChartTopInset),
            weatherChart.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            weatherChart.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            weatherChart.heightAnchor.constraint(equalToConstant: TwentyFourALConstants.weatherChartHeight),

            hourlyTableView.topAnchor.constraint(equalTo: weatherChart.bottomAnchor, constant: TwentyFourALConstants.tableViewTopInset),
            hourlyTableView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            hourlyTableView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            hourlyTableView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            hourlyTableView.heightAnchor.constraint(equalToConstant: TwentyFourALConstants.tableViewHeight)
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


// MARK: - UITableViewDataSource

extension TwentyFourScreenView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        8
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: HourDetailTableViewCell.identifier, for: indexPath) as! HourDetailTableViewCell
        cell.setupCell(model: delegate?.forecast?[indexPath.row])

        return cell
    }


}

// MARK: - UITableViewDelegate

extension TwentyFourScreenView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: .zero)
        return view
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        0
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
