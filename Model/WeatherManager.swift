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
        performRequest(urlString: urlString)
        // Works correctly.
        //print(urlString)
    }
    
    
    func performRequest(urlString: String) {
        // Create a URL
        if let url = URL(string: urlString) {
            // Create a URL session
            let session = URLSession(configuration: .default)
            // Assign a task
            let task = session.dataTask(with: url, completionHandler: handler(data:response:error:))
            // Start the task
            task.resume()
        }
    }

    func handler(data: Data?, response: URLResponse?, error: Error?) {
        if error != nil {
            print(error!)
            return
        }
        
        if let safeData = data {
            parseJSON(weatherData: safeData)
            //let dataString = String(data: safeData, encoding: .utf8)
            //print(dataString)
        }
    }
    
    func parseJSON(weatherData: Data) {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            print(decodedData.weather[0].description)
        } catch {
            print(error)
        }

    }
}
