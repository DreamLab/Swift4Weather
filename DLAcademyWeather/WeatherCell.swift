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
        // Tutaj przypizujemy dane do Labeli jakie są w widoku
    }
}
