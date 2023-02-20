//
//  24hoursForcastViewController.swift
//  Weather
//
//  Created by Нияз Нуруллин on 11.12.2022.
//

import UIKit
import CoreData

class DaySummaryWeatherViewController: UIViewController {

    private var currentCity: CityCoreData!
    private var currentDate: String!

    private lazy var frcForecast1d: NSFetchedResultsController<Forecast1dCoreData> = {
        let request = Forecast1dCoreData.fetchRequest()
        request.predicate = NSPredicate(format: "toCity == %@", currentCity)
        request.sortDescriptors = [NSSortDescriptor(key: "forecastDate", ascending: true)] //

        let frc = NSFetchedResultsController(fetchRequest: request, managedObjectContext: CoreDataManager.defaultManager.persistentContainer.viewContext, sectionNameKeyPath: nil, cacheName: nil)
        return frc
    }()

    private lazy var mainView: DaySummaryScreenView = {
        let view = DaySummaryScreenView()
        view.toAutoLayout()
        view.delegate = self
        view.setupView()

        return view
    }()

    init(city: CityCoreData!, date: String!) {
        self.currentCity = city
        self.currentDate = date
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
        frcForecast1d.delegate = self
        do {
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

    private func setupSubviews() {
        view.addSubview(mainView)
    }

    private func setupSubviewsLayout() {
        NSLayoutConstraint.activate([
            mainView.topAnchor.constraint(equalTo: view.topAnchor),
            mainView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mainView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mainView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }


}

// MARK: - TwentyFourScreenViewDelegate

extension DaySummaryWeatherViewController: DaySummaryScreenViewDelegate {

    var cityLabel: String? {
        guard let city = currentCity.city else { return nil }
        guard let country = currentCity.country else { return nil }

        return "\(city), \(country)"
    }

    var currentForecast: Forecast1dCoreData? {
        return frcForecast1d.fetchedObjects?.first(where: { forecast in
            forecast.forecastDate == currentDate
        })
    }

    var currentWeather: CurrentWeatherCoreData? {
        return currentCity.currentWeather
    }

    var dates: [String]? {
        var dates: [String] = []

        frcForecast1d.fetchedObjects?.forEach({ forecast in
            if let date = forecast.forecastDate {
                dates.append(date)
            }
        })

        if dates.isEmpty {
            return nil
        } else {
            return dates
        }
    }

    func didSelectCellAction(newDate: String, completion: () -> Void) {
        currentDate = newDate
        completion()
    }

}

// MARK: - NSFetchedResultsControllerDelegate

extension DaySummaryWeatherViewController: NSFetchedResultsControllerDelegate {
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {

    }
}
