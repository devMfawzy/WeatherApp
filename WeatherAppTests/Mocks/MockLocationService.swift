//
//  MockLocationService.swift
//  WeatherAppTests
//
//  Created by Mohamed Fawzy on 24/03/2025.
//

import Foundation
@testable import WeatherApp

class MockLocationService: LocationServiceProtocol {
    weak var delegate: LocationServiceDelegate?
    
    var mockLocation: Location?
    var error: LocationError?
    
    var startMonitoringLocationCalled = false
    var stopMonitoringLocationCalled = false
    
    func startMonitoringLocation() {
        startMonitoringLocationCalled = true
        if let mockLocation {
            delegate?.locationService(self, didUpdateLocation: mockLocation)
        } else if let error {
            delegate?.locationService(self, didFailWithError: error)
        }
    }
    
    func stopMonitoringLocation() {
        stopMonitoringLocationCalled = true
    }
}

