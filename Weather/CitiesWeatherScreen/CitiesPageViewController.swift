//
//  CitiesPageViewController.swift
//  Weather
//
//  Created by Нияз Нуруллин on 12.12.2022.
//

import UIKit
import CoreData

class CitiesPageViewController: UIPageViewController {

    private let locationManager = LocationManager.defaultManager

    private var frc: NSFetchedResultsController<CityCoreData> = {
        let request = CityCoreData.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "city", ascending: true)] // в алфавитном порядке во названию города

        let frc = NSFetchedResultsController(fetchRequest: request, managedObjectContext: CoreDataManager.defaultManager.persistentContainer.viewContext, sectionNameKeyPath: nil, cacheName: nil)
        return frc
    }()

    private var addedCitiesVC: [CityViewController] = []

    private lazy var settingsBarButton: UIBarButtonItem = {
        let button = UIBarButtonItem(
            image: UIImage(systemName: "gearshape"),
            style: .plain,
            target: self,
            action: #selector(settingsButtonTap)
        )
        button.tintColor = .black

        return button
    }()

    private lazy var locationBarButton: UIBarButtonItem = {
        let button = UIBarButtonItem(
            image: UIImage(systemName: "mappin.and.ellipse"),
            style: .plain,
            target: self,
            action: #selector(locationButtonTap)
        )
        button.tintColor = .black

        return button
    }()

    private let noCityView: NoCityView = {
        let view = NoCityView()
        view.toAutoLayout()

        return view
    }()

    override init(
        transitionStyle style: UIPageViewController.TransitionStyle,
        navigationOrientation: UIPageViewController.NavigationOrientation,
        options: [UIPageViewController.OptionsKey : Any]? = nil
    ) {
        super.init(transitionStyle: .scroll, navigationOrientation: navigationOrientation)

        dataSource = self
        delegate = self
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        setupFRC()
        startLocationServices()
        super.loadView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        getLocationWeatherIfPossible()
        viewInitialSettings()
    }

    private func startLocationServices() {
        locationManager.startLocation()
        locationManager.vcDelegate = self
    }

    private func getLocationWeatherIfPossible() {
       let status = LocationManager.defaultManager.getPermissionStatus()
        switch status {
        case .authorizedWhenInUse, .authorizedAlways:
            guard let location = LocationManager.defaultManager.getCLCoordinates() else { return }
            NetworkManager.defaultManager.geoRequest(location.longitude, location.latitude) { geoModel in
                CoreDataManager.defaultManager.addCityWithWeatherData(geoModel: geoModel)
            }
        default:
            return
        }
    }

    private func setupFRC() {
        frc.delegate = self
        do {
            try frc.performFetch()
        } catch {
            debugPrint(error.localizedDescription)
        }
    }

    private func viewInitialSettings() {
        view.backgroundColor = UIColor(named: "MainAccentColor")
//        view.backgroundColor = .white

        setupNavigationBar()
        setupSubviews()
        setupSubviewsLayout()
    }

    private func setupNavigationBar() {
        self.navigationController!.navigationBar.isHidden = false
        self.navigationItem.hidesBackButton = true
        self.navigationItem.leftBarButtonItems = [settingsBarButton]
        self.navigationItem.rightBarButtonItems = [locationBarButton]
    }

    private func setupSubviews() {
        updateAddedCities()
        view.addSubview(noCityView)
    }

    private func setupSubviewsLayout() {
        NSLayoutConstraint.activate([
            noCityView.topAnchor.constraint(equalTo: view.topAnchor),
            noCityView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            noCityView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            noCityView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    private func updateAddedCities() {
        guard let cities = frc.fetchedObjects else { return }
        if !cities.isEmpty {
            noCityView.isHidden = true
            addedCitiesVC = []

            for city in cities {
                let vc = CityViewController(city: city)
                if !addedCitiesVC.contains(vc) {
                    addedCitiesVC.append(vc)
                }
            }
            debugPrint("🌞🌞🌞\(addedCitiesVC.count)")
            self.setViewControllers([addedCitiesVC[0]], direction: .forward, animated: true)
        }
    }

    @objc private func locationButtonTap() {
        let alert = AlertHelper.defaultHelper.addCityAlert()
        present(alert, animated: true)
    }

    @objc private func settingsButtonTap() {
        let vc = SettingsViewController()
        self.navigationController!.pushViewController(vc, animated: true)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

// MARK: - UIPageViewControllerDataSource

extension CitiesPageViewController: UIPageViewControllerDataSource {

    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        addedCitiesVC.count
    }

    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        0
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let vc = viewController as? CityViewController else { return nil }
        if let index = addedCitiesVC.firstIndex(of: vc) {
            if index > 0 {
                return addedCitiesVC[index - 1]
            }
        }

        return nil
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let vc = viewController as? CityViewController else { return nil }
        if let index = addedCitiesVC.firstIndex(of: vc) {
            if index < addedCitiesVC.count - 1 {
                return addedCitiesVC[index + 1]
            }
        }

        return nil
    }


}

// MARK: - UIPageViewControllerDelegate

extension CitiesPageViewController: UIPageViewControllerDelegate {

}

// MARK: - NSFetchedResultsControllerDelegate

extension CitiesPageViewController: NSFetchedResultsControllerDelegate {

    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {

        if let newCity = anObject as? CityCoreData {
            guard let _ = newCity.currentWeather else { return }
            guard let forecast3h = newCity.forecast3h else { return }
            guard let forecast1d = newCity.forecast1d else { return }

            if (forecast3h.count != 0) && (forecast1d.count != 0) {
                updateAddedCities()
            }
        }

        view.layoutIfNeeded()
    }

}


extension CitiesPageViewController: LocationManagerDelegate {
    func didChangeAuthorizationAction() {
        getLocationWeatherIfPossible()
    }
}
