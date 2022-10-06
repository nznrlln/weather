//
//  UIView+Extention.swift
//  Weather
//
//  Created by Нияз Нуруллин on 06.10.2022.
//

import UIKit

extension UIView {

    static var identifier: String {
        String(describing: self)
    }

    func toAutoLayout() {
        self.translatesAutoresizingMaskIntoConstraints = false
    }

    func addSubviews(_ subviews: UIView...) {
        subviews.forEach { self.addSubview($0) }
    }

}
