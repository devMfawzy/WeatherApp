//
//  MockWeatherRepository.swift
//  WeatherAppTests
//
//  Created by Mohamed Fawzy on 24/03/2025.
//

import Foundation
@testable import WeatherApp

class MockWeatherRepository: WeatherRepositoryProtocol {
    var mockWeather: Weather?
    var mockCachedWeather: Weather?
    var savedWeather: Weather?
    
    var getWeatherCityCalled = false
    var getWeatherLocationCalled = false
    var getCachedWeatherCalled = false
    var saveWeatherCalled = false
    
    func getWeather(forCity cityName: String) async throws -> Weather {
        getWeatherCityCalled = true
        
        guard let weather = mockWeather else {
            throw NSError(domain: "test", code: 0, userInfo: [NSLocalizedDescriptionKey: "No mock weather"])
        }
        
        return weather
    }
    
    func getWeather(forLocation latitude: Double, longitude: Double) async throws -> Weather {
        getWeatherLocationCalled = true
        
        guard let weather = mockWeather else {
            throw NSError(domain: "test", code: 0, userInfo: [NSLocalizedDescriptionKey: "No mock weather"])
        }
        
        return weather
    }
    
    func getCachedWeather(forCity cityName: String) async throws -> Weather? {
        getCachedWeatherCalled = true
        return mockCachedWeather
    }
    
    func saveWeather(_ weather: Weather) async throws {
        saveWeatherCalled = true
        savedWeather = weather
    }
}
