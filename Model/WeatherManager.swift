//
//  WeatherManager.swift
//  Weather_App
//
//  Created by Elliott Larsen on 6/18/22.
//

import Foundation

struct WeatherManager {
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=6eadca789f2c136d942e4297587eb8a8&units=imperial"
    func getWeather(cityName: String) {
        let urlString = "\(weatherURL)&q=\(cityName)"
        // Works correctly.
        //print(urlString)
    }
}
