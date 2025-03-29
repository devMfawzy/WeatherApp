//
//  SearchHistoryRepositoryTests.swift
//  WeatherAppTests
//
//  Created by Mohamed Fawzy on 24/03/2025.
//

import XCTest
@testable import WeatherApp

class SearchHistoryRepositoryTests: XCTestCase {
    
    func testGetRecentSearchesReturnsDataFromLocalDataSource() async throws {
        // Arrange
        let searches = ["London", "Cairo", "Abu Dhabi"]
        let mockLocalDataSource = MockSearchHistoryLocalDataSource()
        mockLocalDataSource.mockSearches = searches
        
        let repository = SearchHistoryRepository(localDataSource: mockLocalDataSource)
        
        // Act
        let result = try await repository.getRecentSearches()
        
        // Assert
        XCTAssertEqual(result, searches)
        XCTAssertTrue(mockLocalDataSource.getRecentSearchesCalled)
    }
    
    func testAddSearchDelegatesToLocalDataSource() async throws {
        // Arrange
        let mockLocalDataSource = MockSearchHistoryLocalDataSource()
        let repository = SearchHistoryRepository(localDataSource: mockLocalDataSource)
        
        // Act
        try await repository.addSearch("London")
        
        // Assert
        XCTAssertTrue(mockLocalDataSource.saveSearchCalled)
        XCTAssertEqual(mockLocalDataSource.lastSavedSearch, "London")
    }
    
    func testHandlesLocalDataSourceError() async {
        // Arrange
        let mockLocalDataSource = MockSearchHistoryLocalDataSource()
        mockLocalDataSource.shouldThrowError = true
        
        let repository = SearchHistoryRepository(localDataSource: mockLocalDataSource)
        
        // Act & Assert
        do {
            _ = try await repository.getRecentSearches()
            XCTFail("Expected error to be thrown")
        } catch {
            // Success: error was thrown
            XCTAssertTrue(mockLocalDataSource.getRecentSearchesCalled)
        }
    }
}
