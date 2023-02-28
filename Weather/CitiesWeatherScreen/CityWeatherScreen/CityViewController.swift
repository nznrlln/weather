//
//  CityViewController.swift
//  Weather
//
//  Created by Нияз Нуруллин on 18.12.2022.
//

import UIKit
import CoreData

class CityViewController: UIViewController {

    private var currentCity: CityCoreData!

    private lazy var frcForecast3h: NSFetchedResultsController<Forecast3hCoreData> = {
        let request = Forecast3hCoreData.fetchRequest()
        request.predicate = NSPredicate(format: "toCity == %@", currentCity)
        request.sortDescriptors = [NSSortDescriptor(key: "forecastTime", ascending: true)] //

        let frc = NSFetchedResultsController(fetchRequest: request, managedObjectContext: CoreDataManager.defaultManager.persistentContainer.viewContext, sectionNameKeyPath: nil, cacheName: nil)
        return frc
    }()

    private lazy var frcForecast1d: NSFetchedResultsController<Forecast1dCoreData> = {
        let request = Forecast1dCoreData.fetchRequest()
        request.predicate = NSPredicate(format: "toCity == %@", currentCity)
        request.sortDescriptors = [NSSortDescriptor(key: "forecastDate", ascending: true)] //

        let frc = NSFetchedResultsController(fetchRequest: request, managedObjectContext: CoreDataManager.defaultManager.persistentContainer.viewContext, sectionNameKeyPath: "forecastDate", cacheName: nil)
        return frc
    }()

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

    private lazy var dayView: DayWeatherView = {
        let view = DayWeatherView(frame: .zero)
        view.toAutoLayout()
        view.backgroundColor = UIColor(named: "MainAccentColor")
        view.layer.cornerRadius = 5
        view.clipsToBounds = true

        return view
    }()

    private lazy var dayHoursButton: UIButton = {
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
        button.addTarget(self, action: #selector(dayHoursButtonTap), for: .touchUpInside)

        return button
    }()

    private lazy var dayHoursCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.toAutoLayout()
        collectionView.showsHorizontalScrollIndicator = false

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

    private lazy var numberOfDaysButton: CustomDaysButton = {
        let button = CustomDaysButton()
        button.toAutoLayout()
        button.addTarget(self, action: #selector(numberOfDaysButtonTap), for: .touchUpInside)

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

    init(city: CityCoreData!) {
        self.currentCity = city
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        setupFRC()
        super.loadView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        viewInitialSettings()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        self.title = "\(currentCity.city ?? ""), \(currentCity.country ?? "")"
        self.navigationController!.navigationBar.topItem!.title = self.title
        updateViews()
    }

    private func setupFRC() {
        frcForecast3h.delegate = self
        frcForecast1d.delegate = self
        do {
            try frcForecast3h.performFetch()
            try frcForecast1d.performFetch()
        } catch {
            debugPrint(error.localizedDescription)
        }
    }

    private func viewInitialSettings() {
        view.backgroundColor = .white

        setupSubviews()
        setupSubviewsLayout()
    }

    private func updateViews() {
        dayView.setupView(model: currentCity.currentWeather ?? nil)
        dayHoursCollectionView.reloadData()
        daysTableView.reloadData()
    }

    private func setupSubviews() {
        dayView.setupView(model: currentCity.currentWeather ?? nil)
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
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),

            dayView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
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

    @objc private func dayHoursButtonTap() {
        let vc = TwentyFourHoursDetailWeatherViewController(city: currentCity)
        self.navigationController!.pushViewController(vc, animated: true)
    }

    @objc private func numberOfDaysButtonTap() {
        daysTableView.reloadData()
    }

}


// MARK: - UICollectionViewDataSource

extension CityViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        8
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HourlyWeatherCollectionViewCell.identifier, for: indexPath) as! HourlyWeatherCollectionViewCell
        if let objects = frcForecast3h.fetchedObjects,
           !objects.isEmpty {
            cell.setupCell(model: frcForecast3h.object(at: indexPath))
        }

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

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! HourlyWeatherCollectionViewCell
        let vc = TwentyFourHoursDetailWeatherViewController(city: currentCity)
        self.navigationController!.pushViewController(vc, animated: true)
        collectionView.deselectItem(at: indexPath, animated: true)
        cell.setDeselectedState()
    }

    // почему то никогда не вызывается
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! HourlyWeatherCollectionViewCell
        cell.setDeselectedState()
    }

    func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! HourlyWeatherCollectionViewCell
        cell.setHighlightedState()
    }

}


// MARK: - UITableViewDataSource

extension CityViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        if numberOfDaysButton.is7Days {
            return 7
        } else {
            return 16
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DateWeatherTableViewCell.identifier, for: indexPath) as! DateWeatherTableViewCell
        if let objects = frcForecast1d.fetchedObjects,
           !objects.isEmpty {
            cell.setupCell(model: frcForecast1d.object(at: indexPath))
        }

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

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let vc = DaySummaryWeatherViewController(city: currentCity, date: frcForecast1d.object(at: indexPath).forecastDate)
        self.navigationController!.pushViewController(vc, animated: true)
    }
}


// MARK: - NSFetchedResultsControllerDelegate

extension CityViewController: NSFetchedResultsControllerDelegate {

    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {

        if controller == frcForecast3h {
            dayHoursCollectionView.reloadData()
        }
        if controller == frcForecast1d {
            daysTableView.reloadData()
        }
    }

}
