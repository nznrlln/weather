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
        view.setupView()
        
        return view
    }()

    // VIEW ПО ЧАСАМ

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
