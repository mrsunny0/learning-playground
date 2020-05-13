import Foundation

class WeatherService {
    func getWeather(city: String, completion: @escaping (Weather?) -> ()) {
        let apiURI = "https://api.openweathermap.org/data/2.5/weather?q=\(city)&appid=7d777f010144ab86975255e987edd841&units=metric"
        guard let url = URL(string: apiURI) else {
            completion(nil)
            return
        }
        
        URLSession.shared.dataTask(with: url) {data, response, error in
            if let data = data, error == nil {
                if let weatherResponse = try? JSONDecoder().decode(WeatherResponse.self, from: data) {
                    let weather = weatherResponse.main
                    completion(weather)
                } else {
                    completion(nil)
                }
            }
        }.resume()
    }
}
