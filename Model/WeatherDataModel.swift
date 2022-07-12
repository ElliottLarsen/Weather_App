//
//  WeatherDataModel.swift
//  Weather_App
//
//  Created by Elliott Larsen on 6/19/22.
//

import Foundation

struct WeatherDataModel {
    let conditionId: Int
    let cityName: String
    let temperature: Double
    let description: String
    let feelsLike: Double
    let minTemp: Double
    let maxTemp: Double
    let humidity: Double
    
    
    var temperatureString: String {
        return String(format: "%.1f", temperature)
    }
    
    var feelsLikeString: String {
        return String(format: "%.1f", feelsLike)
    }
    
    var minTempString: String {
        return String(format: "%.1f", minTemp)
    }
    
    var maxTempString: String {
        return String(format: "%.1f", maxTemp)
    }
    
    var humidityString: String {
        return String(format: "%.0f", humidity)
    }
    
    
    
    var condidtionName: String {
        switch conditionId {
        case 200...232:
            return "cloud.bolt.fill"
        case 300...321:
            return "cloud.drizzle.fill"
        case 500...531:
            return "cloud.rain.fill"
        case 600...622:
            return "cloud.snow.fill"
        case 701...781:
            return "cloud.fog.fill"
        case 800:
            return "sun.max.fill"
        case 801...804:
            return "cloud.fill"
        default:
            return "sun.max.fill"
        }
    }
}
