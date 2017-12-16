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
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.estimatedRowHeight = 60
        tableView.rowHeight = UITableViewAutomaticDimension
        
        tableView.separatorStyle = .none
        tableView.sectionHeaderHeight = 55
        
        tableView.backgroundView?.backgroundColor = .clear
        tableView.backgroundColor = .clear
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
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 2
        case 1:
            return 5
        default:
            return 0
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "weatherCell") as? WeatherCell, let model = model else {
            return UITableViewCell()
        }
        if indexPath.section == 0 {
            cell.prepare(for: model.shortTermForecast[indexPath.row])
        } else {
            cell.prepare(for: model.longTermForecast[indexPath.row])
        }
        return cell
    }
}

extension WeatherViewController: UITableViewDelegate {
 func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let headerCell = tableView.dequeueReusableCell(withIdentifier: "headerCell") as? HeaderCell else {
            return UITableViewCell()
        }
        if section == 0 {
            headerCell.titleLabel.text = "Prognoza pogody na 48 godz.".uppercased()
        } else {
            headerCell.titleLabel.text = "Prognoza długoterminowa".uppercased()
        }
        return headerCell.contentView
    }
}

