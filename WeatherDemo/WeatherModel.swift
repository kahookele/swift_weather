//
//  WeatherMode.swift
//  WeatherDemo
//
//  Created by Keli'i Kaho'okele on 3/14/25.
//

import Foundation

// Model to decode JSON response
struct WeatherResponse: Codable {
    let main: Main
    let weather: [Weather]
}

struct Main: Codable {
    let temp: Double
}

struct Weather: Codable {
    let description: String
    let icon: String
}
