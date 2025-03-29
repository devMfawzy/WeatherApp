//
//  LocationServiceTests.swift
//  WeatherAppTests
//
//  Created by Mohamed Fawzy on 24/03/2025.
//

import XCTest
@testable import WeatherApp

class LocationServiceTests: XCTestCase {
    var locationService: MockLocationService!
    var mockDelegate: MockLocationServiceDelegate!
    
    override func setUp() {
        super.setUp()
        locationService = MockLocationService()
        mockDelegate = MockLocationServiceDelegate()
        locationService.delegate = mockDelegate
    }
    
    override func tearDown() {
        locationService = nil
        mockDelegate = nil
        super.tearDown()
    }
    
    func testLocationUpdateIsForwardedToDelegate() {
        // Arrange
        let mockLocation = Location(latitude: 51.5074, longitude: -0.1278)
        locationService.mockLocation = mockLocation
        
        // Act
        locationService.startMonitoringLocation()
        
        // Assert
        XCTAssertTrue(locationService.startMonitoringLocationCalled)
        XCTAssertNotNil(mockDelegate.lastLocation)
        XCTAssertEqual(mockDelegate.lastLocation?.latitude, mockLocation.latitude)
        XCTAssertEqual(mockDelegate.lastLocation?.longitude, mockLocation.longitude)
    }
    
    func testLocationErrorIsForwardedToDelegate() {
        // Arrange
        let mockError = LocationError.locationNotFound
        locationService.error = mockError
        
        // Act
        locationService.startMonitoringLocation()
    
        // Assert
        XCTAssertTrue(locationService.startMonitoringLocationCalled)
        XCTAssertNotNil(mockDelegate.lastError)
        // Verify that we receive a LocationError instead of the raw Core Location error
        XCTAssertTrue(mockDelegate.lastError is LocationError)
        XCTAssertEqual(mockDelegate.lastError as? LocationError, .locationNotFound)
    }
    
    func testInLocationStopIsNotForwardingToDelegate() {
        // Arrange
        let location = Location(latitude: 3, longitude: 3)
        locationService.mockLocation = location
        
        // Act
        locationService.stopMonitoringLocation()
    
        // Assert
        XCTAssertTrue(locationService.stopMonitoringLocationCalled)
        XCTAssertNil(mockDelegate.lastError)
        XCTAssertNil(mockDelegate.lastLocation)
    }
}

// Mock LocationServiceDelegate for testing
class MockLocationServiceDelegate: LocationServiceDelegate {
    var lastLocation: Location?
    var lastError: Error?
    
    
    func locationService(_ service: LocationServiceProtocol, didUpdateLocation location: Location) {
        lastLocation = location
    }
    
    func locationService(_ service: LocationServiceProtocol, didFailWithError error: Error) {
        lastError = error
    }
}
