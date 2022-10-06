//
//  SunMoonView.swift
//  Weather
//
//  Created by Нияз Нуруллин on 07.01.2023.
//

import UIKit

enum SunMoon {
    case sun
    case moon
}

class SunMoonView: UIView {

    let viewState: SunMoon!

    private lazy var sunMoonImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.toAutoLayout()
        imageView.contentMode = .scaleAspectFit

        switch self.viewState {
        case .sun:
            imageView.image = UIImage(named: "sun")
        case .moon:
            imageView.image = UIImage(named: "moon")
        case .none:
            imageView.image = UIImage(named: "wind")
        }

        return imageView
    }()

    private let durationLabel: UILabel = {
        let label = UILabel()
        label.toAutoLayout()
        label.font = UIFont(name: "Rubik-Regular", size: 16)
        label.text = "14ч 19мин"

        return label
    }()

    private let riseLabel: UILabel = {
        let label = UILabel()
        label.toAutoLayout()
        label.font = UIFont(name: "Rubik-Regular", size: 14)
        label.textColor = UIColor(named: "SecondaryTextColor")
        label.text = "Восход"

        return label
    }()

    private let riseTimeLabel: UILabel = {
        let label = UILabel()
        label.toAutoLayout()
        label.font = UIFont(name: "Rubik-Regular", size: 16)
        label.text = "05:19"

        return label
    }()

    private let setLabel: UILabel = {
        let label = UILabel()
        label.toAutoLayout()
        label.font = UIFont(name: "Rubik-Regular", size: 14)
        label.textColor = UIColor(named: "SecondaryTextColor")
        label.text = "Заход"

        return label
    }()

    private let setTimeLabel: UILabel = {
        let label = UILabel()
        label.toAutoLayout()
        label.font = UIFont(name: "Rubik-Regular", size: 16)
        label.text = "05:19"

        return label
    }()

    init(frame: CGRect, viewState: SunMoon) {
        self.viewState = viewState
        super.init(frame: frame)

        viewInitialSettings()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func viewInitialSettings() {
        self.backgroundColor = .white

        setupSubviews()
        setupSubviewsLayout()
    }

    private func setupSubviews() {
        self.addSubviews(
            sunMoonImageView, durationLabel,
            riseLabel, riseTimeLabel,
            setLabel, setTimeLabel
        )
    }

    private func setupSubviewsLayout() {
        NSLayoutConstraint.activate([
            sunMoonImageView.centerYAnchor.constraint(equalTo: self.topAnchor, constant: 16),
            sunMoonImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 18),
            sunMoonImageView.heightAnchor.constraint(equalToConstant: 20),
            sunMoonImageView.widthAnchor.constraint(equalToConstant: 20),

            durationLabel.centerYAnchor.constraint(equalTo: sunMoonImageView.centerYAnchor),
            durationLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5),

            riseLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            riseLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 18),

            riseTimeLabel.centerYAnchor.constraint(equalTo: riseLabel.centerYAnchor),
            riseTimeLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5),

            setLabel.centerYAnchor.constraint(equalTo: self.topAnchor, constant: 80),
            setLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 18),

            setTimeLabel.centerYAnchor.constraint(equalTo: setLabel.centerYAnchor),
            setTimeLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5),


        ])

    }

    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
        addDashLine(
            start: CGPoint(x: self.bounds.minX, y: self.bounds.maxY / 3),
            end: CGPoint(x: self.bounds.maxX, y: self.bounds.maxY / 3)
        )

        addDashLine(
            start: CGPoint(x: self.bounds.minX, y: self.bounds.maxY / 3 * 2),
            end: CGPoint(x: self.bounds.maxX, y: self.bounds.maxY / 3 * 2)
        )

    }


    private func addDashLine(start: CGPoint, end: CGPoint) {
        let  path = UIBezierPath()

        path.move(to: start)
        path.addLine(to: end)

        let  dashes: [ CGFloat ] = [ 4.0, 4.0 ]
        path.setLineDash(dashes, count: dashes.count, phase: 2.0)

        path.lineWidth = 0.3
//        path.lineCapStyle = .butt
        UIColor(named: "CustomBlue")?.set()
        path.stroke()
    }

//    func addDashedBorder() {
//            //Create a CAShapeLayer
//            let shapeLayer = CAShapeLayer()
//            shapeLayer.strokeColor = UIColor.red.cgColor
//            shapeLayer.lineWidth = 2
//            // passing an array with the values [2,3] sets a dash pattern that alternates between a 2-user-space-unit-long painted segment and a 3-user-space-unit-long unpainted segment
//            shapeLayer.lineDashPattern = [2,3]
//
//            let path = CGMutablePath()
//            path.addLines(between: [CGPoint(x: 0, y: 0),
//                                    CGPoint(x: self.frame.width, y: 0)])
//            shapeLayer.path = path
//            layer.addSublayer(shapeLayer)
//        }

}
