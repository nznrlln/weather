//
//  DayWeatherView.swift
//  Weather
//
//  Created by Нияз Нуруллин on 18.12.2022.
//

import UIKit

class DayWeatherView: UIView {

    private let ellipseImage: UIImageView = {
        let imageView = UIImageView()
        imageView.toAutoLayout()
        imageView.image = UIImage(named: "ellipse")?.withTintColor(UIColor(named: "CustomYellow") ?? .yellow)

        return imageView
    }()

    private let sunriseImage: UIImageView = {
        let imageView = UIImageView()
        imageView.toAutoLayout()
        imageView.image = UIImage(named: "sunrise")?.withTintColor(UIColor(named: "CustomYellow") ?? .yellow)

        return imageView
    }()

    private let sunriseTimeLabel: UILabel = {
        let label = UILabel()
        label.toAutoLayout()
        label.font = UIFont(name: "Rubik-Medium", size: 14)
        label.textColor = .white
        label.text = "05:41"

        return label
    }()

    private let sunsetImage: UIImageView = {
        let imageView = UIImageView()
        imageView.toAutoLayout()
        imageView.image = UIImage(named: "sunset")?.withTintColor(UIColor(named: "CustomYellow") ?? .yellow)

        return imageView
    }()

    private let sunsetTimeLabel: UILabel = {
        let label = UILabel()
        label.toAutoLayout()
        label.font = UIFont(name: "Rubik-Medium", size: 14)
        label.textColor = .white
        label.text = "19:31"

        return label
    }()

    private let tempRangeLabel: UILabel = {
        let label = UILabel()
        label.toAutoLayout()
        label.font = UIFont(name: "Rubik-Regular", size: 16)
        label.textColor = .white
        label.text = "7" + "º" + "/" + "13" + "º"

        return label
    }()

    private let currentTempLabel: UILabel = {
        let label = UILabel()
        label.toAutoLayout()
        label.font = UIFont(name: "Rubik-Medium", size: 36)
        label.textColor = .white
        label.text = "13" + "º"

        return label
    }()

    private let weatherPredictionLabel: UILabel = {
        let label = UILabel()
        label.toAutoLayout()
        label.font = UIFont(name: "Rubik-Regular", size: 16)
        label.textColor = .white
        label.text = "Возможен небольшой дождь"

        return label
    }()

    private let uvImage: UIImageView = {
        let imageView = UIImageView()
        imageView.toAutoLayout()
        imageView.image = UIImage(named: "sunAndClouds")
        imageView.contentMode = .scaleAspectFit

        return imageView
    }()

    private let uvLabel: UILabel = {
        let label = UILabel()
        label.toAutoLayout()
        label.font = UIFont(name: "Rubik-Regular", size: 14)
        label.textColor = .white
        label.text = "0"

        return label
    }()

    private let uvStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.toAutoLayout()
        stackView.spacing = 2

        return stackView
    }()

    private let windImage: UIImageView = {
        let imageView = UIImageView()
        imageView.toAutoLayout()
        imageView.image = UIImage(named: "wind")?.withTintColor(.white)
        imageView.contentMode = .scaleAspectFit

        return imageView
    }()

    private let windVelocityLabel: UILabel = {
        let label = UILabel()
        label.toAutoLayout()
        label.font = UIFont(name: "Rubik-Regular", size: 14)
        label.textColor = .white
        label.text = "3" + "м/с"

        return label
    }()

    private let windStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.toAutoLayout()
        stackView.spacing = 2

        return stackView
    }()

    private let humidityImage: UIImageView = {
        let imageView = UIImageView()
        imageView.toAutoLayout()
        imageView.image = UIImage(named: "humidity")?.withTintColor(.white)
        imageView.contentMode = .scaleAspectFill

        return imageView
    }()

    private let humidityLabel: UILabel = {
        let label = UILabel()
        label.toAutoLayout()
        label.font = UIFont(name: "Rubik-Regular", size: 14)
        label.textColor = .white
        label.text = "75" + "%"

        return label
    }()

    private let humidityStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.toAutoLayout()
        stackView.spacing = 2

        return stackView
    }()

    private let currentTimeDateLabel: UILabel = {
        let label = UILabel()
        label.toAutoLayout()
        label.font = UIFont(name: "Rubik-Regular", size: 16)
        label.textColor = UIColor(named: "CustomYellow")
        label.text = "17:48, пт 16 апреля"

        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupSubviews()
        setupSubviewsLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupSubviews() {
        uvStackView.addArrangedSubview(uvImage)
        uvStackView.addArrangedSubview(uvLabel)

        windStackView.addArrangedSubview(windImage)
        windStackView.addArrangedSubview(windVelocityLabel)

        humidityStackView.addArrangedSubview(humidityImage)
        humidityStackView.addArrangedSubview(humidityLabel)

        self.addSubviews(
            ellipseImage,
            sunriseImage, sunriseTimeLabel,
            sunsetImage, sunsetTimeLabel,
            tempRangeLabel,
            currentTempLabel,
            weatherPredictionLabel,
            uvStackView, windStackView, humidityStackView,
            currentTimeDateLabel
        )
    }

    private func setupSubviewsLayout() {
        NSLayoutConstraint.activate([
            ellipseImage.topAnchor.constraint(equalTo: self.topAnchor, constant: 17),
            ellipseImage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 32),
            ellipseImage.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -32),
//            ellipseImage.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -72),

            sunriseImage.topAnchor.constraint(equalTo: ellipseImage.bottomAnchor, constant: 8),
            sunriseImage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 25),
//            sunriseImage.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -50),
            sunriseImage.heightAnchor.constraint(equalToConstant: 17),
            sunriseImage.widthAnchor.constraint(equalToConstant: 17),

            sunriseTimeLabel.topAnchor.constraint(equalTo: sunriseImage.bottomAnchor, constant: 5),
            sunriseTimeLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 17),
            sunriseTimeLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -26),

            sunsetImage.topAnchor.constraint(equalTo: ellipseImage.bottomAnchor, constant: 8),
            sunsetImage.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -25),
//            sunsetImage.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -50),
            sunsetImage.heightAnchor.constraint(equalToConstant: 17),
            sunsetImage.widthAnchor.constraint(equalToConstant: 17),

            sunsetTimeLabel.topAnchor.constraint(equalTo: sunsetImage.bottomAnchor, constant: 5),
            sunsetTimeLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -17),
            sunsetTimeLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -26),

            tempRangeLabel.topAnchor.constraint(equalTo: ellipseImage.topAnchor, constant: 16),
            tempRangeLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),

            currentTempLabel.topAnchor.constraint(equalTo: tempRangeLabel.bottomAnchor, constant: 5),
            currentTempLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),

            weatherPredictionLabel.topAnchor.constraint(equalTo: currentTempLabel.bottomAnchor, constant: 5),
            weatherPredictionLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),

            uvStackView.topAnchor.constraint(equalTo: weatherPredictionLabel.bottomAnchor, constant: 15),
            uvStackView.leadingAnchor.constraint(equalTo: ellipseImage.leadingAnchor, constant: 44),
            uvStackView.heightAnchor.constraint(equalToConstant: 18),
            uvStackView.widthAnchor.constraint(equalToConstant: 35),

            windStackView.topAnchor.constraint(equalTo: weatherPredictionLabel.bottomAnchor, constant: 15),
            windStackView.leadingAnchor.constraint(equalTo: uvStackView.trailingAnchor, constant: 19),
            windStackView.heightAnchor.constraint(equalToConstant: 18),
            windStackView.widthAnchor.constraint(equalToConstant: 66),

            humidityStackView.topAnchor.constraint(equalTo: weatherPredictionLabel.bottomAnchor, constant: 15),
            humidityStackView.trailingAnchor.constraint(equalTo: ellipseImage.trailingAnchor, constant: -52),
            humidityStackView.heightAnchor.constraint(equalToConstant: 18),
            humidityStackView.widthAnchor.constraint(equalToConstant: 45),

            currentTimeDateLabel.topAnchor.constraint(equalTo: windStackView.bottomAnchor, constant: 15),
            currentTimeDateLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            currentTimeDateLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -21),


        ])
    }
}

/*
// Only override draw() if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
override func draw(_ rect: CGRect) {
    // Drawing code

//        let bezierPath = UIBezierPath()
//        let startPoint = CGPoint(x: self.bounds.minX + 31, y: self.bounds.maxY - 72)
//        let midPoint = CGPoint(x: self.bounds.width / 2, y: self.bounds.minY + 17)
//        let endPoint = CGPoint(x: self.bounds.maxX - 31, y: self.bounds.maxY - 72)
//
////        let leftPoint = CGPoint(x: 31, y: self.bounds.minY + 17)
////        let rightPoint = CGPoint(x: self.bounds.maxX - 31, y: self.bounds.minY + 17)
//
//        // 0.25*(startPoint.x, startPoint.y) + 0.5(midPoint.x, midPoint.y) + 0.25*
//        let leftPoint = CGPoint(x:  self.bounds.maxX / 10, y: self.bounds.minY + 20 )
//        let rightPoint = CGPoint(x: self.bounds.maxX - self.bounds.maxX / 10, y: self.bounds.minY + 20)
//
//        bezierPath.move(to: startPoint)
//        bezierPath.addQuadCurve(to: midPoint, controlPoint: leftPoint)
//        bezierPath.addQuadCurve(to: endPoint, controlPoint: rightPoint)
//
//
////        bezierPath.addCurve(to: endPoint, controlPoint1: leftPoint, controlPoint2: rightPoint)
////        bezierPath.addCurve(to: endPoint, controlPoint1: rightPoint, controlPoint2: rightPoint)
//        UIColor.yellow.setStroke()
//        bezierPath.lineWidth = 5
//        bezierPath.stroke()


//        let path = UIBezierPath(arcCenter: CGPoint(x: self.bounds.maxX / 2, y: self.bounds.maxY - 72), radius: self.bounds.maxX / 2 - 32, startAngle: -CGFloat.pi, endAngle: 0, clockwise: true)
//        UIColor.yellow.setStroke()
//        path.lineWidth = 5
//        path.stroke()
}
*/
