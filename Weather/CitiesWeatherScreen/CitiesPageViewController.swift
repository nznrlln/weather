//
//  CitiesPageViewController.swift
//  Weather
//
//  Created by Нияз Нуруллин on 12.12.2022.
//

import UIKit
import CoreData

class CitiesPageViewController: UIPageViewController {

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

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        frc.delegate = self
        do {
            try frc.performFetch()
        } catch {
            debugPrint(error.localizedDescription)
        }

        viewInitialSettings()
    }

    private func viewInitialSettings() {
        view.backgroundColor = UIColor(named: "MainAccentColor")

        updateAddedCities()
        self.setViewControllers([addedCitiesVC[0]], direction: .forward, animated: true)

        setupNavigationBar()
    }

    private func setupNavigationBar() {
        self.navigationController!.navigationBar.isHidden = false
        self.navigationItem.hidesBackButton = true
        self.navigationItem.leftBarButtonItems = [settingsBarButton]
        self.navigationItem.rightBarButtonItems = [locationBarButton]
    }

    private func updateAddedCities() {
        guard let cities = frc.fetchedObjects else {
            //вывести вьюшку с пустой страницей
            return
        }
        for city in cities {
            let vc = CityViewController(city: city)
            vc.title = "\(city.city), \(city.country)"
            addedCitiesVC.append(vc)
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

    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChangeContentWith diff: CollectionDifference<NSManagedObjectID>) {
        updateAddedCities()
        view.layoutIfNeeded()
    }
//    func controller(
//        _ controller: NSFetchedResultsController<NSFetchRequestResult>,
//        didChangeContentWith snapshot: NSDiffableDataSourceSnapshotReference
//    ) {
//        updateAddedCities()
//    }


}
