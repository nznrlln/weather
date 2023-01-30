//
//  PermissionScreenView.swift
//  Weather
//
//  Created by Нияз Нуруллин on 28.01.2023.
//

import UIKit

protocol PermissionScreenDelegate: AnyObject {
    func useLocationButtonAction()
    func doNotUseLocationButtonAction()
}

class PermissionScreenView: UIView {

    weak var delegate: PermissionScreenDelegate?

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

        button.addTarget(self, action: #selector(useUserLocationButtonTap), for: .touchUpInside)

        return button
    }()

    private lazy var dontUseUserLocationButton: UIButton = {
        let button = UIButton()
        button.toAutoLayout()
        button.setTitle("НЕТ, Я БУДУ ДОБАВЛЯТЬ ЛОКАЦИИ", for: .normal)
        button.titleLabel?.font = UIFont(name: "Rubik-Regular", size: 16)
        button.titleLabel?.textColor = UIColor(named: "PermissionTextColor")

        button.addTarget(self, action: #selector(doNotUseUserLocationButtonTap), for: .touchUpInside)

        return button
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
        self.addSubviews(umbrellaGirlImageView,
                         useUserLocationDescription1,
                         useUserLocationDescription2,
                         useUserLocationDescription3,
                         useUserLocationButton,
                         dontUseUserLocationButton)
    }

    private func setupSubviewsLayout() {
        NSLayoutConstraint.activate([
            umbrellaGirlImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            umbrellaGirlImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 56),
            umbrellaGirlImageView.heightAnchor.constraint(equalToConstant: PermissionALConstants.umbrellaGirlHeight),
            umbrellaGirlImageView.widthAnchor.constraint(equalToConstant: PermissionALConstants.umbrellaGirlWidth),

            useUserLocationDescription1.topAnchor.constraint(equalTo: umbrellaGirlImageView.bottomAnchor, constant: PermissionALConstants.labelTopInset),
            useUserLocationDescription1.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: PermissionALConstants.labelLeadingInset),
            useUserLocationDescription1.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: PermissionALConstants.labelTrailingInset),

            useUserLocationDescription2.topAnchor.constraint(equalTo: useUserLocationDescription1.bottomAnchor, constant: PermissionALConstants.labelTopInset),
            useUserLocationDescription2.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: PermissionALConstants.labelLeadingInset),
            useUserLocationDescription2.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: PermissionALConstants.labelTrailingInset),

            useUserLocationDescription3.topAnchor.constraint(equalTo: useUserLocationDescription2.bottomAnchor, constant: PermissionALConstants.labelLineSpacing),
            useUserLocationDescription3.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: PermissionALConstants.labelLeadingInset),
            useUserLocationDescription3.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: PermissionALConstants.labelTrailingInset),

            useUserLocationButton.topAnchor.constraint(equalTo: useUserLocationDescription3.bottomAnchor, constant: PermissionALConstants.buttonTopInset),
            useUserLocationButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: PermissionALConstants.buttonLeadingInset),
            useUserLocationButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: PermissionALConstants.buttonTrailingInset),
            useUserLocationButton.heightAnchor.constraint(equalToConstant: PermissionALConstants.buttonHeight),

            dontUseUserLocationButton.topAnchor.constraint(equalTo: useUserLocationButton.bottomAnchor, constant: PermissionALConstants.buttonLineSpacing),
            dontUseUserLocationButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: PermissionALConstants.buttonTrailingInset),
        ])
    }



    @objc private func useUserLocationButtonTap() {
        delegate?.useLocationButtonAction()
    }

    @objc private func doNotUseUserLocationButtonTap() {
        delegate?.doNotUseLocationButtonAction()
    }

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
