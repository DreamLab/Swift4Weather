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
        return forecasts.filter { item in
            return (calendar.isDateInTomorrow(item.date) || calendar.isDateInToday(item.date)) && calendar.component(.hour, from: item.date) == 13
        }
    }
    
    var longTermForecast: [Forecast] {
        guard let tomorrow = calendar.date(byAdding: .day, value: 2, to: Date()), let seventhDay = calendar.date(byAdding: .day, value: 7, to: Date()) else {
            return [Forecast]()
        }
        return forecasts.filter { item in
            return (tomorrow...seventhDay).contains(item.date) && calendar.component(.hour, from: item.date) == 13
        }
    }

    func retreiveData(completion: @escaping () -> Void) {
        Alamofire.request("http://onetsgweatherapi.dreamlab.pl/v1.0/forecast/locations/351898/now-and-tomorrow").responseJSON { response in
            if let json = response.result.value as? Dictionary<String, Any>  {
                guard let forecastData = json["forecast"] as? Dictionary<String, Any>, let forecastDataNow = forecastData["now"] as? Dictionary<String, Any> else {
                    return
                }
                self.generateForecastForNow(forecastData: forecastDataNow)
                //print(self.forecasts)
            }
            if !self.forecasts.isEmpty {
                completion()
            }
        }
        Alamofire.request("http://onetsgweatherapi.dreamlab.pl/v1.0/forecast/locations/351898/long-term").responseJSON { response in
            
            if let json = response.result.value as? Dictionary<String, Any>  {
                guard let forecastData = json["forecast"] as? Array<Dictionary<String, Any>> else {
                    return
                }
                self.forecasts = self.generateForecasts(forecastData: forecastData)
            }
            if self.forecastForNow != nil {
                completion()
            }
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
