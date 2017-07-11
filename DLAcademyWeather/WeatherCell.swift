//
//  WeatherCell.swift
//  DLAcademyWeather
//
//  Created by Szczęsny Kamil on 10.07.2017.
//  Copyright © 2017 Szczęsny Kamil. All rights reserved.
//

import Foundation
import UIKit

class WeatherCell: UITableViewCell {
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var pictogram: UIImageView!
    @IBOutlet weak var realTemp: UILabel!
    @IBOutlet weak var feelTemp: UILabel!
    
    func prepare(for forecast: Forecast) {
        descriptionLabel.text = forecast.description + "bla bla bla dududu"
        descriptionLabel.sizeToFit()
        realTemp.text = Int(forecast.currentTemp.rounded()).description + "°"
        feelTemp.text = Int(forecast.currentFeelTemp.rounded()).description + "°"
        pictogram.image = UIImage(named: forecast.iconId.description)
        dateLabel.text = forecast.dateDescriptionForCell
    }
}
