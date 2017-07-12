//
//  Model.swift
//  DLAcademyWeather
//
//  Created by Szczęsny Kamil on 06.07.2017.
//  Copyright © 2017 Szczęsny Kamil. All rights reserved.
//

import Foundation
import Alamofire

class Model {
    
    var forecasts = [Forecast]()
    var forecastForNow: Forecast?
    
    let calendar = Calendar.current
    let dateFormatter = DateFormatter()
    
    var shortTermForecast: [Forecast] {
        return forecasts
        // Tutaj zwracamy tylko prognozy na jutro i pojutrze
    }
    
    var longTermForecast: [Forecast] {
        return forecasts
        // Tutaj zwracamy tylko prognozy +3 dni do +7 dni
    }

    func retreiveData(completion: @escaping () -> Void) {
        Alamofire.request("http://onetsgweatherapi.dreamlab.pl/v1.0/forecast/locations/351898/now-and-tomorrow").responseJSON { response in
            // tutaj gdy oba requesty zwróciły dane wołamy completion
        }
        Alamofire.request("http://onetsgweatherapi.dreamlab.pl/v1.0/forecast/locations/351898/long-term").responseJSON { response in
            // tutaj gdy oba requesty zwróciły dane wołamy completion
        }
    }
    
    private func generateForecasts(forecastData: Array<Dictionary<String, Any>>) -> [Forecast] {
        return forecastData.map { item in
                guard let item = item as? Dictionary<String, Any> else {
                    return nil
                }
                return Forecast(item: item)
            }.flatMap { item in
                item
            }
    }
    
    private func generateForecastForNow(forecastData: Dictionary<String, Any>) {
        forecastForNow = Forecast(item: forecastData)
    }
}
