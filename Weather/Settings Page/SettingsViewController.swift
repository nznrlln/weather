//
//  SettingsViewController.swift
//  Weather
//
//  Created by Нияз Нуруллин on 10.12.2022.
//

import UIKit

class SettingsViewController: UIViewController {

    private let backgroundView: UIView = {
        let view = UIView()
        view.toAutoLayout()

        return view
    }()

    private let cloud1Image: UIImageView = {
        let view = UIImageView()
        view.toAutoLayout()
        view.image = UIImage(named: "cloud1")
        view.alpha = 0.5

        return view
    }()

    private let cloud2Image: UIImageView = {
        let view = UIImageView()
        view.toAutoLayout()
        view.image = UIImage(named: "cloud2")
        view.alpha = 0.5

        return view
    }()

    private let cloud3Image: UIImageView = {
        let view = UIImageView()
        view.toAutoLayout()
        view.image = UIImage(named: "cloud3")
        view.alpha = 0.5

        return view
    }()

    private let settingsLabel: UILabel = {
        let label = UILabel()
        label.toAutoLayout()
        label.text = "Настройки"
        label.font = UIFont(name: "Rubik-Medium", size: 18)

        return label
    }()

    private let temperatureUnitsLabel: UILabel = {
        let label = UILabel()
        label.toAutoLayout()
        label.text = "Температура"
        label.font = UIFont(name: "Rubik-Medium", size: 18)

        return label
    }()

    private let temperatureSegmentedControl: UISegmentedControl = {
        let control = UISegmentedControl()
        control.toAutoLayout()
        control.insertSegment(withTitle: "℉", at: 0, animated: true)
        control.insertSegment(withTitle: "℃", at: 1, animated: true)
        control.selectedSegmentTintColor = UIColor(named: "MainAccentColor")
        control.backgroundColor = UIColor(named: "MainBackgroundColor")
        control.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: .selected)
        control.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.black], for: .normal)
        control.selectedSegmentIndex = 1

        return control
    }()

    private let windVelocityLabel: UILabel = {
        let label = UILabel()
        label.toAutoLayout()
        label.text = "Скорость ветра"
        label.font = UIFont(name: "Rubik-Medium", size: 18)

        return label
    }()

    private let windVelocitySegmentedControl: UISegmentedControl = {
        let control = UISegmentedControl()
        control.toAutoLayout()
        control.insertSegment(withTitle: "Mi/H", at: 0, animated: true)
        control.insertSegment(withTitle: "Kh/H", at: 1, animated: true)
        control.selectedSegmentTintColor = UIColor(named: "MainAccentColor")
        control.backgroundColor = UIColor(named: "MainBackgroundColor")
        control.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: .selected)
        control.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.black], for: .normal)
        control.selectedSegmentIndex = 1

        return control
    }()

    private let timeFormatLabel: UILabel = {
        let label = UILabel()
        label.toAutoLayout()
        label.text = "Формат времени"
        label.font = UIFont(name: "Rubik-Medium", size: 18)

        return label
    }()

    private let timeFormatSegmentedControl: UISegmentedControl = {
        let control = UISegmentedControl()
        control.toAutoLayout()
        control.insertSegment(withTitle: "12", at: 0, animated: true)
        control.insertSegment(withTitle: "24", at: 1, animated: true)
        control.selectedSegmentTintColor = UIColor(named: "MainAccentColor")
        control.backgroundColor = UIColor(named: "MainBackgroundColor")
        control.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: .selected)
        control.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.black], for: .normal)
        control.selectedSegmentIndex = 1

        return control
    }()

    private let notificationsStateLabel: UILabel = {
        let label = UILabel()
        label.toAutoLayout()
        label.text = "Уведомления"
        label.font = UIFont(name: "Rubik-Medium", size: 18)

        return label
    }()

    private let notificationsStateSegmentedControl: UISegmentedControl = {
        let control = UISegmentedControl()
        control.toAutoLayout()
        control.insertSegment(withTitle: "On", at: 0, animated: true)
        control.insertSegment(withTitle: "Off", at: 1, animated: true)
        control.selectedSegmentTintColor = UIColor(named: "MainAccentColor")
        control.backgroundColor = UIColor(named: "MainBackgroundColor")
        control.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: .selected)
        control.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.black], for: .normal)
        control.selectedSegmentIndex = 1

        return control
    }()

    private let confirmSettingsButton: UIButton = {
        let button = UIButton()
        button.toAutoLayout()
        button.backgroundColor = UIColor(named: "ButtonColor")
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        button.setTitle("Установить", for: .normal)

        return button
    }()

    private let settingsContentView: UIView = {
        let view = UIView(frame: .zero)
        view.toAutoLayout()
        view.backgroundColor = UIColor(named: "MainBackgroundColor")
        view.layer.cornerRadius = 10
        view.clipsToBounds = true

        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        viewInitialSettings()
    }

    private func viewInitialSettings() {
        view.backgroundColor = UIColor(named: "MainAccentColor")

        setupSubviews()
        setupSubviewsLayout()
    }

    private func setupSubviews() {
        backgroundView.addSubviews(cloud1Image, cloud2Image, cloud3Image)
        settingsContentView.addSubviews(settingsLabel,
                                        temperatureUnitsLabel, temperatureSegmentedControl,
                                        windVelocityLabel, windVelocitySegmentedControl,
                                        timeFormatLabel, timeFormatSegmentedControl,
                                        notificationsStateLabel, notificationsStateSegmentedControl,
                                        confirmSettingsButton)

        view.addSubviews(backgroundView, settingsContentView)
    }

    private func setupSubviewsLayout() {
        NSLayoutConstraint.activate([
            backgroundView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            cloud1Image.centerXAnchor.constraint(equalTo: backgroundView.leadingAnchor),
            cloud2Image.centerXAnchor.constraint(equalTo: backgroundView.trailingAnchor),
            cloud2Image.topAnchor.constraint(equalTo: cloud1Image.bottomAnchor, constant: 20),
            cloud3Image.centerXAnchor.constraint(equalTo: backgroundView.centerXAnchor),
            cloud3Image.bottomAnchor.constraint(equalTo: backgroundView.bottomAnchor, constant: -40),

            settingsContentView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            settingsContentView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            settingsContentView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: ALConstants.settingsContentViewXInset),
            settingsContentView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -ALConstants.settingsContentViewXInset),

            settingsLabel.topAnchor.constraint(equalTo: settingsContentView.topAnchor, constant: 27),
            settingsLabel.leadingAnchor.constraint(equalTo: settingsContentView.leadingAnchor, constant: 20),

            temperatureUnitsLabel.topAnchor.constraint(equalTo: settingsLabel.bottomAnchor, constant: 20),
            temperatureUnitsLabel.leadingAnchor.constraint(equalTo: settingsContentView.leadingAnchor, constant: 20),

            windVelocityLabel.topAnchor.constraint(equalTo: temperatureUnitsLabel.bottomAnchor, constant: 30),
            windVelocityLabel.leadingAnchor.constraint(equalTo: settingsContentView.leadingAnchor, constant: 20),

            timeFormatLabel.topAnchor.constraint(equalTo: windVelocityLabel.bottomAnchor, constant: 30),
            timeFormatLabel.leadingAnchor.constraint(equalTo: settingsContentView.leadingAnchor, constant: 20),

            notificationsStateLabel.topAnchor.constraint(equalTo: timeFormatLabel.bottomAnchor, constant: 30),
            notificationsStateLabel.leadingAnchor.constraint(equalTo: settingsContentView.leadingAnchor, constant: 20),

            temperatureSegmentedControl.topAnchor.constraint(equalTo: settingsLabel.bottomAnchor, constant: 15),
            temperatureSegmentedControl.trailingAnchor.constraint(equalTo: settingsContentView.trailingAnchor, constant: ALConstants.segmentControlTrailingInset),
            temperatureSegmentedControl.heightAnchor.constraint(equalToConstant: ALConstants.segmentControHeight),
            temperatureSegmentedControl.widthAnchor.constraint(equalToConstant: ALConstants.segmentControWidth),

            windVelocitySegmentedControl.topAnchor.constraint(equalTo: temperatureSegmentedControl.bottomAnchor, constant: ALConstants.segmentControlYSpacing),
            windVelocitySegmentedControl.trailingAnchor.constraint(equalTo: settingsContentView.trailingAnchor, constant: ALConstants.segmentControlTrailingInset),
            windVelocitySegmentedControl.heightAnchor.constraint(equalToConstant: ALConstants.segmentControHeight),
            windVelocitySegmentedControl.widthAnchor.constraint(equalToConstant: ALConstants.segmentControWidth),

            timeFormatSegmentedControl.topAnchor.constraint(equalTo: windVelocitySegmentedControl.bottomAnchor, constant: ALConstants.segmentControlYSpacing),
            timeFormatSegmentedControl.trailingAnchor.constraint(equalTo: settingsContentView.trailingAnchor, constant: ALConstants.segmentControlTrailingInset),
            timeFormatSegmentedControl.heightAnchor.constraint(equalToConstant: ALConstants.segmentControHeight),
            timeFormatSegmentedControl.widthAnchor.constraint(equalToConstant: ALConstants.segmentControWidth),

            notificationsStateSegmentedControl.topAnchor.constraint(equalTo: timeFormatSegmentedControl.bottomAnchor, constant: ALConstants.segmentControlYSpacing),
            notificationsStateSegmentedControl.trailingAnchor.constraint(equalTo: settingsContentView.trailingAnchor, constant: ALConstants.segmentControlTrailingInset),
            notificationsStateSegmentedControl.heightAnchor.constraint(equalToConstant: ALConstants.segmentControHeight),
            notificationsStateSegmentedControl.widthAnchor.constraint(equalToConstant: ALConstants.segmentControWidth),



            confirmSettingsButton.topAnchor.constraint(equalTo: notificationsStateSegmentedControl.bottomAnchor, constant: 37),
            confirmSettingsButton.leadingAnchor.constraint(equalTo: settingsContentView.leadingAnchor, constant: ALConstants.settingsConfirmButtonXInset),
            confirmSettingsButton.trailingAnchor.constraint(equalTo: settingsContentView.trailingAnchor, constant: -ALConstants.settingsConfirmButtonXInset),
            confirmSettingsButton.bottomAnchor.constraint(equalTo: settingsContentView.bottomAnchor, constant: -ALConstants.settingsConfirmButtonYInset),
            confirmSettingsButton.heightAnchor.constraint(equalToConstant: ALConstants.settingsConfirmButtonHeight)

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
