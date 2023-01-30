//
//  CustomDaysButton.swift
//  Weather
//
//  Created by Нияз Нуруллин on 30.01.2023.
//

import Foundation
import UIKit

class CustomDaysButton: UIButton {

    enum numberOfDays: Int {
        case days7 = 7
        case days16 = 16
    }

    private let days7Text = NSAttributedString(
        string: "7 дней",
        attributes: [
            NSAttributedString.Key.underlineStyle : NSUnderlineStyle.single.rawValue,
            NSAttributedString.Key.font : UIFont(name: "Rubik-Regular", size: 16)!
        ]
    )

    private let days16Text = NSAttributedString(
        string: "16 дней",
        attributes: [
            NSAttributedString.Key.underlineStyle : NSUnderlineStyle.single.rawValue,
            NSAttributedString.Key.font : UIFont(name: "Rubik-Regular", size: 16)!
        ]
    )

    var is7Days: Bool = false {
        didSet {
            if is7Days == true {
                self.setAttributedTitle(days7Text, for: .normal)
            } else {
                self.setAttributedTitle(days16Text, for: .normal)
            }
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        self.is7Days = true
        self.setAttributedTitle(days7Text, for: .normal)
        self.addTarget(self, action: #selector(customDaysButtonTap), for: .touchUpInside)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func toogle() {
        is7Days = !is7Days
    }

    @objc private func customDaysButtonTap() {
        toogle()
        debugPrint("7 days: \(is7Days)")
    }

}
