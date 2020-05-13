import Foundation
import UIKit
import Combine

class WeatherViewModel: ObservableObject {
    
    @Published var weather = Weather()
    private var weatherService: WeatherService
    var cityName: String = ""
    var temperature: String {
        if let temp = self.weather.temp {
            return String(format: "%.2f", temp)
        } else {
            return ""
        }
    }
    var humidity: String {
        if let humidity = self.weather.humidity {
            return String(format: "%.2f", humidity)
        } else {
            return ""
        }
    }
    
    private func fetchWeather(by city: String) {
        self.weatherService.getWeather(city: city) { (weather) in
            if let weather = weather {
                DispatchQueue.main.async {
                    self.weather = weather
                }
            }
        }
    }
    
    func search() {
        if let city = self.cityName.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) {
            fetchWeather(by: city)
        }
    }
    
    init() {
        self.weatherService = WeatherService()
    }
}
