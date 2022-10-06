//
//  CitiesPageViewController.swift
//  Weather
//
//  Created by Нияз Нуруллин on 12.12.2022.
//

import UIKit

class CitiesPageViewController: UIPageViewController {

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

    }

    private func setupSubviewsLayout() {

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
