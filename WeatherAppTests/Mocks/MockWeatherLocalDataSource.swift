//
//  MockWeatherLocalDataSource.swift
//  WeatherAppTests
//
//  Created by Mohamed Fawzy on 24/03/2025.
//

import Foundation
@testable import WeatherApp

class MockWeatherLocalDataSource {
    var mockWeatherLocal: WeatherLocal?
    var savedWeatherLocal: WeatherLocal?
    var shouldThrowError = false
    
    var getWeatherCalled = false
    var saveWeatherCalled = false
    
    func getWeather(forCity cityName: String) throws -> WeatherLocal? {
        getWeatherCalled = true
        
        if shouldThrowError {
            throw NSError(domain: "test", code: 0)
        }
        
        return mockWeatherLocal
    }
    
    func saveWeather(_ weather: WeatherLocal) throws {
        saveWeatherCalled = true
        savedWeatherLocal = weather
        
        if shouldThrowError {
            throw NSError(domain: "test", code: 0)
        }
    }
}
