//
//  WeatherManager.swift
//  Weather_App
//
//  Created by Elliott Larsen on 6/18/22.
//

import Foundation
import CoreLocation

protocol WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherDataModel)
    func didError(error: Error)
}

struct WeatherManager {
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=6eadca789f2c136d942e4297587eb8a8&units=imperial"
    var delegate: WeatherManagerDelegate?
    
    func getWeather(cityName: String) {
        let urlString = "\(weatherURL)&q=\(cityName)"
        performRequest(urlString: urlString)
        // Works correctly.
        //print(urlString)
    }
    
    func fetchWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        let urlString = "\(weatherURL)&lat=\(latitude)&lon=\(longitude)"
        performRequest(urlString: urlString)
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
            delegate?.didError(error: error!)
            print(error!)
            return
        }
        
        if let safeData = data {
            if let weather = parseJSON(safeData) {
                delegate?.didUpdateWeather(self, weather: weather)
            }
            //let dataString = String(data: safeData, encoding: .utf8)
            //print(dataString)
        }
    }
    
    func parseJSON(_ weatherData: Data) -> WeatherDataModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            let description = decodedData.weather[0].description
            let id = decodedData.weather[0].id
            let temp = decodedData.main.temp
            let name = decodedData.name
            
            let weather = WeatherDataModel(conditionId: id, cityName: name, temperature: temp, description: description)
            return weather
            //print(weather.condidtionName)
            //print(weather.temperatureString)
        } catch {
            delegate?.didError(error: error)
            print(error)
            return nil
        }
    }
}
