//
//  ViewController.swift
//  Clima
//
//  Created by Angela Yu on 01/09/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit
import CoreLocation

//MARK: - UIViewController
class WeatherViewController: UIViewController {

    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var homeButton: UIButton!
    
    var weatherManager = WeatherManager()
    var locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // let the protocol run the methods
        // in this delegate protocol
        // this mainly setups the callback
        searchTextField.delegate = self
        
        // set delegate to own weather manager class
        weatherManager.delegate = self
        
        // need to trigger request
        // order matters!
        locationManager.requestWhenInUseAuthorization()
        locationManager.delegate = self
        locationManager.requestLocation()
    }
    
    // request current location when
    // home button is pressed
    @IBAction func onHomeClick(_ sender: UIButton) {
        print("Home button Pressed")
        locationManager.requestLocation()
    }
}


//MARK: - UITextFieldDelegate
extension WeatherViewController: UITextFieldDelegate {
    @IBAction func searchPressed(_ sender: UIButton) {
        let cityName = searchTextField.text!
    
        // fetch
        weatherManager.fetchWeather(city: cityName)
        
        // finish UI text
        searchTextField.endEditing(true)

    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let cityName = searchTextField.text!
        weatherManager.fetchWeather(city: cityName)
        searchTextField.endEditing(true)
        print(searchTextField.text!)
        return true
    }

    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != "" {
            return true
        } else {
            textField.placeholder = "Type something"
            return false
        }
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        // remove the text to restart
        searchTextField.text = ""
    }
}

//MARK: - WeatherManagerDelegate
extension WeatherViewController: WeatherManagerDelegate {
    // protocol for updating weather
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel) {
        // update view by unpacking weather struct
        let temperature = weather.tempString
        let name = weather.name
        let icon = weather.conditionName
        
        // set dispatch queue to complete
        // running of completion handler (aka, HTTP request)
        // note that his is a callback, has {} instead of ()
        DispatchQueue.main.async {
            self.temperatureLabel.text = temperature
            self.cityLabel.text = name
            self.conditionImageView.image = UIImage(systemName: icon)
        }
    }
    
    // protocol
    func didFailWithError(error: Error) {
        print(error)
    }
}

//MARK: - Location Manager Delegate
extension WeatherViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            // stop calling, so it can be called again
            locationManager.stopUpdatingLocation()
            
            // update lat and lon
            let latitude = location.coordinate.latitude
            let longitude = location.coordinate.longitude
            print("\(latitude) \(longitude)")
            
            // fetch weather from coordinates
            weatherManager.fetchWeather(lat: latitude, lon: longitude)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}
