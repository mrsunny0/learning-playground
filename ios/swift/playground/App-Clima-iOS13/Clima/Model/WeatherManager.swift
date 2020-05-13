import Foundation
import UIKit
import CoreLocation
// free API key: 7d777f010144ab86975255e987edd841

// create the protocol which defines the delegate
protocol WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel)
    func didFailWithError(error: Error)
}

struct WeatherManager {
    // send call to API key
    let baseURI = "https://api.openweathermap.org/data/2.5/weather?q=%@&appid=7d777f010144ab86975255e987edd841&units=metric"
    let latlonURI = "https://api.openweathermap.org/data/2.5/weather?lat=%.2f&lon=%.2f&appid=7d777f010144ab86975255e987edd841&units=metric"
    
    // create a delegate from the main controller
    // to share data beween
    var delegate: WeatherManagerDelegate?
    
    func fetchWeather(city: String) {
        let URI = String(format: baseURI, city)
        performRequest(urlString: URI)
    }
    
    func fetchWeather(lat: CLLocationDegrees, lon: CLLocationDegrees) {
        let latFloat = Float(lat)
        let lonFloat = Float(lon)
        let URI = String(format: latlonURI, latFloat, lonFloat)
        print(URI)
        performRequest(urlString: URI)
    }
    
    func performRequest(urlString: String) {
        
        // optional URL, check
        if let url = URL(string: urlString) {
            // create url session
            let session = URLSession(configuration: .default)
            
            // create the task
            // and give it a callback
            let task = session.dataTask(with: url) { (data, urlResponse, error) in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                
                if let safeData = data {
                    // string encoding
                    // let dataString = String(data: safeData, encoding: .utf8)
                    // print(dataString!)
                    
                    // parse JSON
                    if let weather = self.parseJSON(safeData) {
                        self.delegate?.didUpdateWeather(self, weather: weather)
                    }
                }
            }
            
            // start task
            task.resume()
        }
    }
    
    func parseJSON(_ weatherData: Data) -> WeatherModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            let name = decodedData.name
            let temp = decodedData.main.temp
            let id = decodedData.weather[0].id
            let weatherModel = WeatherModel(conditionId: id, name: name, temperature: temp)
            return weatherModel
            
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
}

// let task = session.dataTask(with: url, completionHandler: handle(data: response: error:))
//            let task = session.dataTask(with: url, completionHandler: {
//                (data: Data?, response: URLResponse?, error: Error?) in
//                if error != nil {
//                    print(error!)
//                    return
//                }
//
//                if let safeData = data {
//                    let dataString = String(data: safeData, encoding: .utf8)
//                    print(dataString!)
//                }
//            })
    
//    func handle(data: Data?, response: URLResponse?, error: Error?) -> Void {
//        if error != nil {
//            print(error!)
//            return
//        }
//
//        if let safeData = data {
//            let dataString =  String(data: safeData, encoding: .utf8)
//            print(dataString!)
//        }
//
//    }
