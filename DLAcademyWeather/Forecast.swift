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
    
    var dateDescriptionForCell: String {
        let calendar = Calendar.current
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat  = "EEEE"
        dateFormatter.locale = Locale(identifier: "pl_PL")
        
        var dateDescription = ""
        if calendar.isDateInToday(date) {
            dateFormatter.dateFormat = "dd MMMM"
            dateDescription = "Dziś " + dateFormatter.string(from: date)
        } else if calendar.isDateInTomorrow(date) {
            dateFormatter.dateFormat = "dd MMMM"
            dateDescription = "Jutro " + dateFormatter.string(from: date)
        } else {
            dateFormatter.dateFormat = "EEEE dd MMMM"
            dateDescription = dateFormatter.string(from: date)
        }
        return dateDescription.capitalized
    }
    
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
            dateFormatter.timeZone = TimeZone.autoupdatingCurrent //TimeZone(abbreviation: "UTC")
            date = dateFormatter.date(from: utcTimeString) ?? Date()
            //dateFormatter.timeZone = TimeZone.autoupdatingCurrent
        } else {
            return nil
        }
        
        iconId = weatherState["id"] as? Int ?? 0
        description = weatherState["description"] as? String ?? ""
    }
}
