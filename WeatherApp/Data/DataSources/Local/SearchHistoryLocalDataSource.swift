//
//  SearchHistoryLocalDataSource.swift
//  WeatherApp
//
//  Created by Mohamed Fawzy on 21/03/2025.
//

import Foundation

class SearchHistoryLocalDataSource: SearchHistoryLocalDataSourceProtocol {
    private let userDefaults = UserDefaults.standard
    private let recentSearchesKey = "recentSearches"
    private let maxSearches = 5
    
    func getRecentSearches() throws -> [String] {
        return userDefaults.stringArray(forKey: recentSearchesKey) ?? []
    }
    
    func saveSearch(_ cityName: String) throws {
        var searches = userDefaults.stringArray(forKey: recentSearchesKey) ?? []
        
        // Remove existing entry if present
        searches.removeAll { $0 == cityName }
        
        // Add at the beginning
        searches.insert(cityName, at: 0)
        
        // Limit to max number of searches
        if searches.count > maxSearches {
            searches = Array(searches.prefix(maxSearches))
        }
        
        userDefaults.set(searches, forKey: recentSearchesKey)
    }
}

protocol SearchHistoryLocalDataSourceProtocol {
    func getRecentSearches() throws -> [String]
    func saveSearch(_ cityName: String) throws
}
