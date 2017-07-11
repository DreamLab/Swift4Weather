//
//  LoadingViewController.swift
//  DLAcademyWeather
//
//  Created by Szczęsny Kamil on 03.07.2017.
//  Copyright © 2017 Szczęsny Kamil. All rights reserved.
//

import Foundation
import UIKit

class LoadingViewController: UIViewController {
    
    let model = Model()
    var forecastForToday: Forecast?
    
    override func viewWillAppear(_ animated: Bool) {
        model.retreiveData {
            self.performSegue(withIdentifier: "showWeather", sender: nil)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let desitinationViewController = segue.destination as? WeatherViewController else {
            return
        }
        desitinationViewController.model = model
    }
}
