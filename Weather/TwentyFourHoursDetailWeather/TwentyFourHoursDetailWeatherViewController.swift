//
//  TwentyFourHoursDetailWeatherViewController.swift
//  Weather
//
//  Created by Нияз Нуруллин on 05.01.2023.
//

import UIKit
import CoreData

class TwentyFourHoursDetailWeatherViewController: UIViewController {

    private var currentCity: CityCoreData!

    private lazy var frcForecast3h: NSFetchedResultsController<Forecast3hCoreData> = {
        let request = Forecast3hCoreData.fetchRequest()
        request.predicate = NSPredicate(format: "toCity == %@", currentCity)
        request.sortDescriptors = [NSSortDescriptor(key: "forecastTime", ascending: true)] //

        let frc = NSFetchedResultsController(fetchRequest: request, managedObjectContext: CoreDataManager.defaultManager.persistentContainer.viewContext, sectionNameKeyPath: nil, cacheName: nil)
        return frc
    }()

    private lazy var mainView: TwentyFourScreenView = {
        let view = TwentyFourScreenView()
        view.toAutoLayout()
        view.delegate = self
        view.setupTitle()
        
        return view
    }()
    
//    private let scrollView: UIScrollView = {
//        let scrollView = UIScrollView()
//        scrollView.toAutoLayout()
//
//        return scrollView
//    }()
//
//    private let contentView: UIView = {
//        let view = UIView()
//        view.toAutoLayout()
//
//        return view
//    }()
//
//    private let cityLabel: UILabel = {
//        let label = UILabel()
//        label.toAutoLayout()
//        label.font = UIFont(name: "Rubik-Medium", size: 18)
//        label.text = "Текущий город"
//
//        return label
//    }()

    // VIEW ПО ЧАСАМ

//    private lazy var hourlyTableView: UITableView = {
//        let tableView = UITableView(frame: .zero, style: .grouped)
//        tableView.toAutoLayout()
//        tableView.backgroundColor = .systemBackground
//        tableView.separatorColor = UIColor(named: "CustomBlue")
//        tableView.separatorInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
//
//        tableView.register(HourDetailTableViewCell.self, forCellReuseIdentifier: HourDetailTableViewCell.identifier)
//        tableView.dataSource = self
//        tableView.delegate = self
//
//        return tableView
//    }()

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

    private func setupFRC() {
        frcForecast3h.delegate = self
        do {
            try frcForecast3h.performFetch()
        } catch {
            debugPrint(error.localizedDescription)
        }
    }

    private func viewInitialSettings() {
        view.backgroundColor = .white

        setupSubviews()
        setupSubviewsLayout()
    }

    private func setupSubviews() {
//        contentView.addSubviews(cityLabel, hourlyTableView)
//        scrollView.addSubview(contentView)
//        view.addSubview(scrollView)

        view.addSubview(mainView)
    }

    private func setupSubviewsLayout() {
        NSLayoutConstraint.activate([
            mainView.topAnchor.constraint(equalTo: view.topAnchor),
            mainView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mainView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mainView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),

//            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
//            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
//
//            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
//            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
//            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
//            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
//            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
//
//            cityLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 65),
//            cityLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 48),
//
//            hourlyTableView.topAnchor.constraint(equalTo: cityLabel.bottomAnchor, constant: 20),
//            hourlyTableView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
//            hourlyTableView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
//            hourlyTableView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
//            hourlyTableView.heightAnchor.constraint(equalToConstant: 800)

        ])
    }


}



    // MARK: - UITableViewDelegate

//}
//// MARK: - UITableViewDataSource
//
//extension TwentyFourHoursDetailWeatherViewController: UITableViewDataSource {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        8
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: HourDetailTableViewCell.identifier, for: indexPath) as! HourDetailTableViewCell
//
//        return cell
//    }
//
//
//}
//
//// MARK: - UITableViewDelegate
//
//extension TwentyFourHoursDetailWeatherViewController: UITableViewDelegate {
//
//}

// MARK: - TwentyFourScreenViewDelegate

extension TwentyFourHoursDetailWeatherViewController: TwentyFourScreenViewDelegate {
    var cityLabel: String? {
        guard let city = currentCity.city else { return nil }
        guard let country = currentCity.country else { return nil }

        return "\(city), \(country)"
    }

    var forecast: [Forecast3hCoreData]? {
       return frcForecast3h.fetchedObjects
    }
}

// MARK: - NSFetchedResultsControllerDelegate

extension TwentyFourHoursDetailWeatherViewController: NSFetchedResultsControllerDelegate {

    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {

    }

}
