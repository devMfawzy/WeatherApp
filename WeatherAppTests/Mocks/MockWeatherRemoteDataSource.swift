//
//  MockWeatherRemoteDataSource.swift
//  WeatherAppTests
//
//  Created by Mohamed Fawzy on 24/03/2025.
//

import Foundation
@testable import WeatherApp

class MockWeatherRemoteDataSource {
    var mockWeatherDTO: WeatherResponseDTO?
    var shouldThrowError = false
    
    var getWeatherForCityCalled = false
    var getWeatherForLocationCalled = false
    
    func getWeather(forCity cityName: String) async throws -> WeatherResponseDTO {
        getWeatherForCityCalled = true
        
        if shouldThrowError {
            throw NSError(domain: "test", code: 0)
        }
        
        guard let weatherDTO = mockWeatherDTO else {
            throw NSError(domain: "test", code: 0, userInfo: [NSLocalizedDescriptionKey: "No mock weather DTO"])
        }
        
        return weatherDTO
    }
    
    func getWeather(forLocation latitude: Double, longitude: Double) async throws -> WeatherResponseDTO {
        getWeatherForLocationCalled = true
        
        if shouldThrowError {
            throw NSError(domain: "test", code: 0)
        }
        
        guard let weatherDTO = mockWeatherDTO else {
            throw NSError(domain: "test", code: 0, userInfo: [NSLocalizedDescriptionKey: "No mock weather DTO"])
        }
        
        return weatherDTO
    }
}
