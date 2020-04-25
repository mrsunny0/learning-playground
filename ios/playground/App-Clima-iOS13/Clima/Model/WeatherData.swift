//
//  WeatherData.swift
//  Clima
//
//  Created by George Sun on 4/24/20.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import Foundation

//struct WeatherData: Decodable, Encodable {
struct WeatherData: Decodable {
    let name: String
    let main: Main
    let weather: Array<Weather>
}

struct Main: Decodable {
    let temp: Double
}

struct Weather: Decodable {
    let id: Int
    let main: String
    let description: String
    let icon: String
}
