//
//  WeatherUIModel.swift
//  WeatherApp
//
//  Created by Mohamed Fawzy on 18/03/2025.
//

import Foundation

struct WeatherUIModel: Identifiable {
    let id: Int
    let cityName: String
    let temperature: String
    let description: String
    let humidity: String
    let windSpeed: String
    let iconURL: URL?
    
    static func fromDomain(_ domain: Weather) -> WeatherUIModel {
        let iconURL = URL(string: "https://openweathermap.org/img/wn/\(domain.iconCode)@2x.png")
        
        return WeatherUIModel(
            id: domain.cityId,
            cityName: domain.cityName,
            temperature: "\(Int(round(domain.temperature)))°C",
            description: domain.description.capitalized,
            humidity: "Humidity: \(domain.humidity)%",
            windSpeed: "Wind: \(domain.windSpeed) m/s",
            iconURL: iconURL
        )
    }
}
