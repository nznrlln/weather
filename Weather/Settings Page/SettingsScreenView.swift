//
//  SettingsScreenView.swift
//  Weather
//
//  Created by Нияз Нуруллин on 28.01.2023.
//

import UIKit

protocol SettingsScreenViewDelegate {
    func confirmSettingsButtonTapAction(_ temperature: Int,_ velocity: Int,_ timeFormat: Int)
}

class SettingsScreenView: UIView {

    var delegate: SettingsScreenViewDelegate?

    private let backgroundView: UIView = {
        let view = UIView()
        view.toAutoLayout()
        view.clipsToBounds = true

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
        control.insertSegment(withTitle: "℃", at: 0, animated: true)
        control.insertSegment(withTitle: "℉", at: 1, animated: true)
        control.selectedSegmentTintColor = UIColor(named: "MainAccentColor")
        control.backgroundColor = UIColor(named: "MainBackgroundColor")
        control.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: .selected)
        control.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.black], for: .normal)
        control.selectedSegmentIndex = 0

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
        control.insertSegment(withTitle: "m/s", at:0, animated: true)
        control.insertSegment(withTitle: "Mi/h", at: 1, animated: true)
        control.selectedSegmentTintColor = UIColor(named: "MainAccentColor")
        control.backgroundColor = UIColor(named: "MainBackgroundColor")
        control.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: .selected)
        control.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.black], for: .normal)
        control.selectedSegmentIndex = 0

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
        control.insertSegment(withTitle: "24", at: 0, animated: true)
        control.insertSegment(withTitle: "12", at: 1, animated: true)
        control.selectedSegmentTintColor = UIColor(named: "MainAccentColor")
        control.backgroundColor = UIColor(named: "MainBackgroundColor")
        control.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: .selected)
        control.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.black], for: .normal)
        control.selectedSegmentIndex = 0

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
        control.insertSegment(withTitle: "Off", at: 0, animated: true)
        control.insertSegment(withTitle: "On", at: 1, animated: true)
        control.selectedSegmentTintColor = UIColor(named: "MainAccentColor")
        control.backgroundColor = UIColor(named: "MainBackgroundColor")
        control.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: .selected)
        control.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.black], for: .normal)
        control.selectedSegmentIndex = 0

        return control
    }()

    private lazy var confirmSettingsButton: UIButton = {
        let button = UIButton()
        button.toAutoLayout()
        button.backgroundColor = UIColor(named: "ButtonColor")
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        button.setTitle("Установить", for: .normal)
        button.addTarget(self, action: #selector(confirmSettingsButtonTap), for: .touchUpInside)

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

    init() {
        super.init(frame: .zero)
        viewInitialSettings()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func viewInitialSettings() {
        self.backgroundColor = UIColor(named: "MainAccentColor")

        setupSubviews()
        setupSubviewsLayout()
    }

    private func setupSubviews() {
        backgroundView.addSubviews(cloud1Image, cloud2Image, cloud3Image)
        settingsContentView.addSubviews(
            settingsLabel,
            temperatureUnitsLabel, temperatureSegmentedControl,
            windVelocityLabel, windVelocitySegmentedControl,
            timeFormatLabel, timeFormatSegmentedControl,
            notificationsStateLabel, notificationsStateSegmentedControl,
            confirmSettingsButton
        )
        self.addSubviews(backgroundView, settingsContentView)
    }

    private func setupSubviewsLayout() {
        NSLayoutConstraint.activate([
            backgroundView.topAnchor.constraint(equalTo: self.topAnchor),
            backgroundView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            cloud1Image.centerXAnchor.constraint(equalTo: backgroundView.leadingAnchor),
            cloud2Image.centerXAnchor.constraint(equalTo: backgroundView.trailingAnchor),
            cloud2Image.topAnchor.constraint(equalTo: cloud1Image.bottomAnchor, constant: 20),
            cloud3Image.centerXAnchor.constraint(equalTo: backgroundView.centerXAnchor),
            cloud3Image.bottomAnchor.constraint(equalTo: backgroundView.bottomAnchor, constant: -40),
            
            settingsContentView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            settingsContentView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            settingsContentView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: SettingsALConstants.settingsContentViewXInset),
            settingsContentView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -SettingsALConstants.settingsContentViewXInset),
            
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
            temperatureSegmentedControl.trailingAnchor.constraint(equalTo: settingsContentView.trailingAnchor, constant: SettingsALConstants.segmentControlTrailingInset),
            temperatureSegmentedControl.heightAnchor.constraint(equalToConstant: SettingsALConstants.segmentControHeight),
            temperatureSegmentedControl.widthAnchor.constraint(equalToConstant: SettingsALConstants.segmentControWidth),
            
            windVelocitySegmentedControl.topAnchor.constraint(equalTo: temperatureSegmentedControl.bottomAnchor, constant: SettingsALConstants.segmentControlYSpacing),
            windVelocitySegmentedControl.trailingAnchor.constraint(equalTo: settingsContentView.trailingAnchor, constant: SettingsALConstants.segmentControlTrailingInset),
            windVelocitySegmentedControl.heightAnchor.constraint(equalToConstant: SettingsALConstants.segmentControHeight),
            windVelocitySegmentedControl.widthAnchor.constraint(equalToConstant: SettingsALConstants.segmentControWidth),
            
            timeFormatSegmentedControl.topAnchor.constraint(equalTo: windVelocitySegmentedControl.bottomAnchor, constant: SettingsALConstants.segmentControlYSpacing),
            timeFormatSegmentedControl.trailingAnchor.constraint(equalTo: settingsContentView.trailingAnchor, constant: SettingsALConstants.segmentControlTrailingInset),
            timeFormatSegmentedControl.heightAnchor.constraint(equalToConstant: SettingsALConstants.segmentControHeight),
            timeFormatSegmentedControl.widthAnchor.constraint(equalToConstant: SettingsALConstants.segmentControWidth),
            
            notificationsStateSegmentedControl.topAnchor.constraint(equalTo: timeFormatSegmentedControl.bottomAnchor, constant: SettingsALConstants.segmentControlYSpacing),
            notificationsStateSegmentedControl.trailingAnchor.constraint(equalTo: settingsContentView.trailingAnchor, constant: SettingsALConstants.segmentControlTrailingInset),
            notificationsStateSegmentedControl.heightAnchor.constraint(equalToConstant: SettingsALConstants.segmentControHeight),
            notificationsStateSegmentedControl.widthAnchor.constraint(equalToConstant: SettingsALConstants.segmentControWidth),
            
            
            
            confirmSettingsButton.topAnchor.constraint(equalTo: notificationsStateSegmentedControl.bottomAnchor, constant: 37),
            confirmSettingsButton.leadingAnchor.constraint(equalTo: settingsContentView.leadingAnchor, constant: SettingsALConstants.settingsConfirmButtonXInset),
            confirmSettingsButton.trailingAnchor.constraint(equalTo: settingsContentView.trailingAnchor, constant: -SettingsALConstants.settingsConfirmButtonXInset),
            confirmSettingsButton.bottomAnchor.constraint(equalTo: settingsContentView.bottomAnchor, constant: -SettingsALConstants.settingsConfirmButtonYInset),
            confirmSettingsButton.heightAnchor.constraint(equalToConstant: SettingsALConstants.settingsConfirmButtonHeight)
            
        ])
    }

    @objc private func confirmSettingsButtonTap() {
        let temperature = temperatureSegmentedControl.selectedSegmentIndex
        let velocity = windVelocitySegmentedControl.selectedSegmentIndex
        let timeFormat = timeFormatSegmentedControl.selectedSegmentIndex
        delegate?.confirmSettingsButtonTapAction(temperature, velocity, timeFormat)
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
