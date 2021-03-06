//
//  ViewController.swift
//  Weather_App
//
//  Created by Elliott Larsen on 6/15/22.
//

import UIKit
import CoreLocation


class ViewController: UIViewController, UITextFieldDelegate, WeatherManagerDelegate {
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var cityLable: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    
    @IBOutlet weak var minTempLogo: UIImageView!
    @IBOutlet weak var feelsLikeLogo: UIImageView!
    @IBOutlet weak var maxTempLogo: UIImageView!
    @IBOutlet weak var humidityLogo: UIImageView!
    
    @IBOutlet weak var minTempLabel: UILabel!
    @IBOutlet weak var maxTempLabel: UILabel!
    @IBOutlet weak var feelsLikeLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var weatherConditionLabel: UILabel!
    @IBOutlet weak var bottomLabel: UILabel!
    
    
    var weatherManager = WeatherManager()
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Round out edges.
        bottomLabel.layer.cornerRadius = 50
        bottomLabel.clipsToBounds = true
        
        minTempLogo.layer.cornerRadius = 15
        minTempLogo.clipsToBounds = true
        
        maxTempLogo.layer.cornerRadius = 15
        maxTempLogo.clipsToBounds = true
        
        feelsLikeLogo.layer.cornerRadius = 15
        feelsLikeLogo.clipsToBounds = true
        
        humidityLogo.layer.cornerRadius = 15
        humidityLogo.clipsToBounds = true
        // Ask permission to get the user location.
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()

        weatherManager.delegate = self
        // TextField notifies the current ViewCotroller.
        searchTextField.delegate = self
    }

    @IBAction func searchButton(_ sender: UIButton) {
        // Hide the keyboard once search button is tapped.
        searchTextField.endEditing(true)
        print(searchTextField.text!)
    }
 
    // This function is called when the return button on the keyboard is tapped.
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Hide the keyboard once the return button is tapped.
        searchTextField.endEditing(true)
        print(searchTextField.text!)
        return true
    }
    
    // Change the placeholder message if the user tries to enter an empty string.
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if searchTextField.text == "" {
            textField.placeholder = "Please enter a city."
            return false
        } else {
            return true
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        // Catch the user input and send it to WeatherManager.swift.
        if var city = searchTextField.text {
            // Check if the city name has a white space.
            var hasWhiteSpace = false
            for char in city {
                if char == " " {
                    hasWhiteSpace = true
                } else {
                    continue
                }
            }
            if hasWhiteSpace == true {
                city = city.replacingOccurrences(of: " ", with: "%20", options: .literal, range: nil)
            }
            //print(city)
            weatherManager.getWeather(cityName: city)
        }
        // Clear our the text field.
        searchTextField.text = ""
    }
    
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherDataModel) {
        // Update UI.
        DispatchQueue.main.async {
            self.cityLable.text = weather.cityName
            self.temperatureLabel.text = "\(weather.temperatureString) ??F"
            print(weather.feelsLikeString)
            print(weather.maxTempString)
            print(weather.minTempString)
            print(weather.humidityString)
            self.weatherConditionLabel.text = weather.description.capitalized
            self.minTempLabel.text = "\(weather.minTempString) ??F"
            self.maxTempLabel.text = "\(weather.maxTempString) ??F"
            self.feelsLikeLabel.text = "\(weather.feelsLikeString) ??F"
            self.humidityLabel.text = "\(weather.humidityString) %"
            //self.weatherDetailLabel.text = "Feels Like: \(weather.feelsLikeString) ??F \nMin Temp: \(weather.minTempString) ??F \nMax Temp: \(weather.maxTempString) ??F \nHumidity: \(weather.humidityString) %"
            self.conditionImageView.image = UIImage(systemName: weather.condidtionName)
        }
        //print(weather.description.capitalized)
        //print(weather.temperature)
    }
    
    func didError(error: Error) {
        print(error)
    }
    @IBAction func locationButton(_ sender: UIButton) {
        locationManager.requestLocation()
    }
}

// CLLocationManagerDelegate.
extension ViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last{
            locationManager.stopUpdatingLocation()
            let latitude = location.coordinate.latitude
            let longitude = location.coordinate.longitude
            weatherManager.fetchWeather(latitude: latitude, longitude: longitude)
            //print("Location Data Received.")
            //print(latitude)
            //print(longitude)
        } else{
            print("This is an Optional.")
        }
        
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}
