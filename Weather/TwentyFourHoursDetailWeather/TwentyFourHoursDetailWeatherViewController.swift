//
//  TwentyFourHoursDetailWeatherViewController.swift
//  Weather
//
//  Created by Нияз Нуруллин on 05.01.2023.
//

import UIKit

class TwentyFourHoursDetailWeatherViewController: UIViewController {
    
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

    // VIEW ПО ЧАСАМ

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
        contentView.addSubviews(cityLabel, hourlyTableView)
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
            cityLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 48),

            hourlyTableView.topAnchor.constraint(equalTo: cityLabel.bottomAnchor, constant: 20),
            hourlyTableView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            hourlyTableView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            hourlyTableView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            hourlyTableView.heightAnchor.constraint(equalToConstant: 800)

        ])
    }


}


// MARK: - UITableViewDataSource

extension TwentyFourHoursDetailWeatherViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        8
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: HourDetailTableViewCell.identifier, for: indexPath) as! HourDetailTableViewCell

        return cell
    }


}

// MARK: - UITableViewDelegate

extension TwentyFourHoursDetailWeatherViewController: UITableViewDelegate {
   
}
