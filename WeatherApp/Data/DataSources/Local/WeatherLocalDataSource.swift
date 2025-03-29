//
//  WeatherLocalDataSource.swift
//  WeatherApp
//
//  Created by Mohamed Fawzy on 18/03/2025.
//

import Foundation

class WeatherLocalDataSource {
    private let userDefaults = UserDefaults.standard
    
    func getWeather(forCity cityName: String) throws -> WeatherLocal? {
        guard let data = userDefaults.data(forKey: "weather_\(cityName.lowercased())") else {
            return nil
        }
        
        return try JSONDecoder().decode(WeatherLocal.self, from: data)
    }
    
    func saveWeather(_ weather: WeatherLocal) throws {
        let data = try JSONEncoder().encode(weather)
        userDefaults.set(data, forKey: "weather_\(weather.cityName.lowercased())")
    }
}
