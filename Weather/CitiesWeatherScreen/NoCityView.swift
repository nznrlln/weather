//
//  NoCityView.swift
//  Weather
//
//  Created by Нияз Нуруллин on 30.01.2023.
//

import UIKit

class NoCityView: UIView {

    private let plusImageView: UIImageView = {
        let view = UIImageView()
        view.toAutoLayout()
        view.image = UIImage(named: "plus")

        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white

        self.addSubview(plusImageView)
        NSLayoutConstraint.activate([
            plusImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            plusImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            plusImageView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height / 3),
            plusImageView.widthAnchor.constraint(equalTo: plusImageView.heightAnchor)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
