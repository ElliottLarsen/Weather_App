//
//  WeatherData.swift
//  Weather_App
//
//  Created by Elliott Larsen on 6/19/22.
//

import Foundation

struct WeatherData: Codable {
    let name: String
    let main: Main
    let weather: [Weather]
}

struct Main: Codable {
    let temp: Double
    let feels_like: Double
    let temp_min: Double
    let temp_max: Double
    let humidity: Double
}

struct Weather: Codable {
    let description: String
    let id: Int
}
