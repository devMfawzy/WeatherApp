//
//  ManageSearchHistoryUseCaseTests.swift
//  WeatherAppTests
//
//  Created by Mohamed Fawzy on 24/03/2025.
//

import XCTest
@testable import WeatherApp

class ManageSearchHistoryUseCaseTests: XCTestCase {
    var mockRepository: MockSearchHistoryRepository!
    
    override func setUp() {
        super.setUp()
        mockRepository = MockSearchHistoryRepository()
    }
    
    override func tearDown() {
        mockRepository = nil
        super.tearDown()
    }
    
    func testGetRecentSearchesReturnsFromRepository() async throws {
        // Arrange
        let searchs = ["A", "B", "C"]
        mockRepository.searchs = searchs
        
        let useCase = ManageSearchHistoryUseCase(repository: mockRepository)
        
        // Act
        let result = try await useCase.getRecentSearches()
        
        // Assert
        XCTAssertEqual(result, searchs)
        XCTAssertTrue(mockRepository.getRecentSearchesCalled)
    }
    
    func testAddSearchTermDelegatesToRepository() async throws {
        // Arrange
        let useCase = ManageSearchHistoryUseCase(repository: mockRepository)
        
        // Act
        try await useCase.addSearchTerm("London")
        
        // Assert
        XCTAssertTrue(mockRepository.addSearchCalled)
        XCTAssertEqual(mockRepository.lastAddedSearch, "London")
    }
    
    func testHandlesRepositoryError() async {
        // Arrange
        mockRepository.shouldThrowError = true
        let useCase = ManageSearchHistoryUseCase(repository: mockRepository)
        
        // Act & Assert
        do {
            _ = try await useCase.getRecentSearches()
            XCTFail("Expected error to be thrown")
        } catch {
            // Success: error was thrown
            XCTAssertTrue(mockRepository.getRecentSearchesCalled)
        }
    }
}
