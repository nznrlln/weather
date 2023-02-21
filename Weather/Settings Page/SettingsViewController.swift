//
//  SettingsViewController.swift
//  Weather
//
//  Created by Нияз Нуруллин on 10.12.2022.
//

import UIKit

class SettingsViewController: UIViewController {

    private lazy var mainView: SettingsScreenView = {
        let view = SettingsScreenView()
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
        self.navigationController?.navigationBar.tintColor = .black

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
            mainView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
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


// MARK: - SettingsScreenViewDelegate

extension SettingsViewController: SettingsScreenViewDelegate {
    func confirmSettingsButtonTapAction(_ temperature: Int, _ velocity: Int, _ timeFormat: Int, _ notifications: Int) {
        UserDefaultSettings.temperatureUnit = TemperatureUnits(rawValue: temperature) ?? .celsius
        UserDefaultSettings.velocityUnit = VelocityUnits(rawValue: velocity) ?? .meterPerSecond
        UserDefaultSettings.timeFormat = TimeFormat(rawValue: timeFormat) ?? .fullDay
        UserDefaultSettings.notificationStatus = NotificationStatus(rawValue: notifications) ?? .off

        let alert = AlertHelper.defaultHelper.showSettingsAlert()
        present(alert, animated: true)

        debugPrint("\(UserDefaultSettings.temperatureUnit), \(UserDefaultSettings.velocityUnit), \(UserDefaultSettings.timeFormat), \(UserDefaultSettings.notificationStatus)")
    }
}
