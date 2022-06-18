//
//  ViewController.swift
//  Weather_App
//
//  Created by Elliott Larsen on 6/15/22.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var cityLable: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    
    var weatherManager = WeatherManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        if let city = searchTextField.text {
            weatherManager.getWeather(cityName: city)
        }
        // Clear our the text field.
        searchTextField.text = ""
    }
}

