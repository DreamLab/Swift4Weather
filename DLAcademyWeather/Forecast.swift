//
//  Forecast.swift
//  DLAcademyWeather
//
//  Created by Szczęsny Kamil on 07.07.2017.
//  Copyright © 2017 Szczęsny Kamil. All rights reserved.
//

import Foundation

struct Forecast {
    var currentTemp = 0.0
    var currentFeelTemp = 0.0
    var iconId: Int
    var description: String
    var date: Date
    
    init?(item: Dictionary<String, Any>) {
        guard let weatherState = item["weatherState"] as? [String: Any] else {
            return nil
        }
        if let currentTempNumber = item["temperature"] as? NSNumber {
            currentTemp = currentTempNumber.doubleValue
        }
        
        if let currentFeelTempNumber = item["sensedTemperature"] as? NSNumber {
            currentFeelTemp = currentFeelTempNumber.doubleValue
        }
        
        if let timeData = item["time"] as? [String: String], let utcTimeString = timeData["local"] {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
            dateFormatter.timeZone = TimeZone.autoupdatingCurrent
            date = dateFormatter.date(from: utcTimeString) ?? Date()
        } else {
            return nil
        }
        
        iconId = weatherState["id"] as? Int ?? 0
        description = weatherState["description"] as? String ?? ""
    }
}
