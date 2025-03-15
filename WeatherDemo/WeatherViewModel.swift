//
//  WeatherViewModel.swift
//  WeatherDemo
//
//  Created by Keli'i Kaho'okele on 3/14/25.
//

import SwiftUI

class WeatherViewModel: ObservableObject {
    @Published var temperature: String = "--°F"
    @Published var description: String = "Loading..."
    @Published var iconName: String = "cloud.fill" // Default icon
    @Published var condition: String = "" // ✅ Added this property

    func fetchWeather() {
        let apiKey = "4873d610f3aadfc4f447223a2e37124f" // API Key
        let urlString = "https://api.openweathermap.org/data/2.5/weather?q=Honolulu&appid=\(apiKey)&units=imperial"
        
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let data = data {
                do {
                    let decodedData = try JSONDecoder().decode(WeatherResponse.self, from: data)
                    
                    DispatchQueue.main.async {
                        self.temperature = "\(Int(decodedData.main.temp))°F"
                        self.description = decodedData.weather.first?.description.capitalized ?? "Clear"
                        self.iconName = self.mapIcon(weatherCode: decodedData.weather.first?.icon ?? "01d")
                        self.condition = self.mapCondition(weatherCode: decodedData.weather.first?.icon ?? "01d") // ✅ Update condition
                    }
                } catch {
                    print("Error decoding JSON: \(error)")
                }
            }
        }.resume()
    }

    func mapIcon(weatherCode: String) -> String {
        let iconMapping: [String: String] = [
            "01d": "sun.max.fill",
            "01n": "moon.fill",
            "02d": "cloud.sun.fill",
            "02n": "cloud.moon.fill",
            "03d": "cloud.fill",
            "04d": "smoke.fill",
            "09d": "cloud.drizzle.fill",
            "10d": "cloud.rain.fill",
            "11d": "cloud.bolt.fill",
            "13d": "snowflake",
            "50d": "cloud.fog.fill"
        ]
        return iconMapping[weatherCode] ?? "cloud.fill"
    }

    // ✅ Function to map weather codes to condition names
    func mapCondition(weatherCode: String) -> String {
        let conditionMapping: [String: String] = [
            "01d": "Sunny",
            "01n": "Clear Night",
            "02d": "Cloudy",
            "02n": "Cloudy Night",
            "03d": "Cloudy",
            "04d": "Cloudy",
            "09d": "Rain",
            "10d": "Rain",
            "11d": "Storm",
            "13d": "Snow",
            "50d": "Fog"
        ]
        return conditionMapping[weatherCode] ?? "Unknown"
    }
}
