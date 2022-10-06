//
//  PermissionViewController.swift
//  Weather
//
//  Created by Нияз Нуруллин on 06.10.2022.
//

import UIKit

class PermissionViewController: UIViewController {

    private let umbrellaGirlImageView: UIImageView = {
        let view = UIImageView()
        view.toAutoLayout()
        view.image = UIImage(named: "UmbrellaGirl")
        view.contentMode = .scaleAspectFill

        return view
    }()

    private let useUserLocationDescription1: UILabel = {
        let label = UILabel()
        label.toAutoLayout()
        label.text = "Разрешить приложению Weather использовать данные о местоположении вашего устройства"
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = UIFont(name: "Rubik-SemiBold", size: 16)
        label.textColor = UIColor(named: "PermissionTextColor")

        return label
    }()

    private let useUserLocationDescription2: UILabel = {
        let label = UILabel()
        label.toAutoLayout()
        label.text = "Чтобы получить более точные прогнозы погоды во время движения или путешествия"
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = UIFont(name: "Rubik-Regular", size: 14)
        label.textColor = UIColor(named: "PermissionTextColor")

        return label
    }()

    private let useUserLocationDescription3: UILabel = {
        let label = UILabel()
        label.toAutoLayout()
        label.text = "Вы можете изменить свой выбор в любое время из меню приложения"
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = UIFont(name: "Rubik-Regular", size: 14)
        label.textColor = UIColor(named: "PermissionTextColor")

        return label
    }()

    private lazy var useUserLocationButton: UIButton = {
        let button = UIButton()
        button.toAutoLayout()
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        button.backgroundColor = UIColor(named: "ButtonColor")
        button.setTitle("ИСПОЛЬЗОВАТЬ МЕСТОПОЛОЖЕНИЕ УСТРОЙСТВА", for: .normal)
        button.titleLabel?.font = UIFont(name: "Rubik-Medium", size: 12)
        button.titleLabel?.textColor = UIColor(named: "PermissionTextColor")

        return button
    }()

    private lazy var dontUseUserLocationButton: UIButton = {
        let button = UIButton()
        button.toAutoLayout()
        button.setTitle("НЕТ, Я БУДУ ДОБАВЛЯТЬ ЛОКАЦИИ", for: .normal)
        button.titleLabel?.font = UIFont(name: "Rubik-Regular", size: 16)
        button.titleLabel?.textColor = UIColor(named: "PermissionTextColor")

        return button
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
        view.addSubviews(umbrellaGirlImageView,
                         useUserLocationDescription1,
                         useUserLocationDescription2,
                         useUserLocationDescription3,
                         useUserLocationButton,
                         dontUseUserLocationButton)
    }

    private func setupSubviewsLayout() {
        NSLayoutConstraint.activate([
            umbrellaGirlImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            umbrellaGirlImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 148),
            umbrellaGirlImageView.heightAnchor.constraint(equalToConstant: ALConstants.umbrellaGirlHeight),
            umbrellaGirlImageView.widthAnchor.constraint(equalToConstant: ALConstants.umbrellaGirlWidth),

            useUserLocationDescription1.topAnchor.constraint(equalTo: umbrellaGirlImageView.bottomAnchor, constant: 56),
            useUserLocationDescription1.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            useUserLocationDescription1.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),

            useUserLocationDescription2.topAnchor.constraint(equalTo: useUserLocationDescription1.bottomAnchor, constant: 56),
            useUserLocationDescription2.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            useUserLocationDescription2.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),

            useUserLocationDescription3.topAnchor.constraint(equalTo: useUserLocationDescription2.bottomAnchor, constant: 14),
            useUserLocationDescription3.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            useUserLocationDescription3.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),

            useUserLocationButton.topAnchor.constraint(equalTo: useUserLocationDescription3.bottomAnchor, constant: 44),
            useUserLocationButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 17),
            useUserLocationButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -17),
            useUserLocationButton.heightAnchor.constraint(equalToConstant: 40),


            dontUseUserLocationButton.topAnchor.constraint(equalTo: useUserLocationButton.bottomAnchor, constant: 25),
            dontUseUserLocationButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -17),

        ])
    }


}
