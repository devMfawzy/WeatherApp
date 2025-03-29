//
//  MockSearchHistoryLocalDataSource.swift
//  WeatherAppTests
//
//  Created by Mohamed Fawzy on 24/03/2025.
//

import XCTest
@testable import WeatherApp

class MockSearchHistoryLocalDataSource: SearchHistoryLocalDataSourceProtocol {
    var mockSearches: [String] = []
    var lastSavedSearch: String?
    var shouldThrowError = false
    
    var getRecentSearchesCalled = false
    var saveSearchCalled = false
    
    func getRecentSearches() throws -> [String] {
        getRecentSearchesCalled = true
        
        if shouldThrowError {
            throw NSError(domain: "test", code: 0)
        }
        
        return mockSearches
    }
    
    func saveSearch(_ cityName: String) throws {
        saveSearchCalled = true
        lastSavedSearch = cityName
        
        if shouldThrowError {
            throw NSError(domain: "test", code: 0)
        }
        
        if !mockSearches.contains(cityName) {
            mockSearches.insert(cityName, at: 0)
            if mockSearches.count > 5 {
                mockSearches = Array(mockSearches.prefix(5))
            }
        } else {
            mockSearches.removeAll { $0 == cityName }
            mockSearches.insert(cityName, at: 0)
        }
    }
}
