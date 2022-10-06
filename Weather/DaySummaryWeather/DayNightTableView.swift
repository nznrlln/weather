//
//  DayNightTableView.swift
//  Weather
//
//  Created by Нияз Нуруллин on 07.01.2023.
//

import UIKit

class DayNightTableView: UITableView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}

extension DayNightTableView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        5
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DayNightTableViewCell.identifier, for: indexPath) as! DayNightTableViewCell

        if indexPath.section == 0 {
            if indexPath.row == 0 {
                cell.setupCell("thermometer", "По ощущениям", "?")
            } else if indexPath.row == 1 {
                cell.setupCell("wind", "Ветер", "?")
            } else if indexPath.row == 2 {
                cell.setupCell("sun", "Уф индекс", "?")
            } else if indexPath.row == 3 {
                cell.setupCell("rain", "Дождь", "?")
            } else if indexPath.row == 4 {
                cell.setupCell("cloudy", "Облачность", "?")
            }
        }

        return cell
    }


}

extension DayNightTableView: UITableViewDelegate {
}

