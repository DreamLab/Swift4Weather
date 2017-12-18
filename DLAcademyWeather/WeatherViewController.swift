//
//  WeatherViewController.swift
//  DLAcademyWeather
//
//  Created by Szczęsny Kamil on 03.07.2017.
//  Copyright © 2017 Szczęsny Kamil. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController {
    
    // Outlets
    @IBOutlet weak var topView: TopView!
    @IBOutlet weak var tableView: UITableView!
    
    // Data to be configured
    weak var model: Model?
    
    // https://developer.apple.com/documentation/uikit/uiviewcontroller
    override func viewDidLoad() {
        super.viewDidLoad()
        // tutaj przygotowac ustawienia tabelki
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard let forecast = model?.forecastForNow else {
            return
        }
        topView.prepareView(with: forecast)
    }
}

// MARK: - UITableViewDataSource
extension WeatherViewController: UITableViewDataSource {
    // tutaj metody z data source
}

// MARK: - UITableViewDelegate
extension WeatherViewController: UITableViewDelegate {
    // tutaj metody z delegata
}

