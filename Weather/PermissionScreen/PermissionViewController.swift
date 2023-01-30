//
//  PermissionViewController.swift
//  Weather
//
//  Created by Нияз Нуруллин on 06.10.2022.
//

import UIKit

class PermissionViewController: UIViewController {

    private lazy var mainView: PermissionScreenView = {
        let view = PermissionScreenView()
        view.toAutoLayout()
        view.delegate = self

        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        viewInitialSettings()
    }

    private func viewInitialSettings() {
        view.backgroundColor = UIColor(named: "MainAccentColor")
//
        setupSubviews()
        setupSubviewsLayout()
    }

    private func setupSubviews() {
        view.addSubview(mainView)
    }

    private func setupSubviewsLayout() {
        NSLayoutConstraint.activate([
            mainView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            mainView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mainView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mainView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }

}


// MARK: - PermissionScreenDelegate
extension PermissionViewController: PermissionScreenDelegate {
    func useLocationButtonAction() {
        LocationManager.defaultManager.getPermission()
        let vc = CitiesPageViewController()
        navigationController!.pushViewController(vc, animated: true)
    }

    func doNotUseLocationButtonAction() {
        let vc = CitiesPageViewController()
        navigationController!.pushViewController(vc, animated: true)
    }


}
