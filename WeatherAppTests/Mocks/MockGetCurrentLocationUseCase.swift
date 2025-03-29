//
//  MockGetCurrentLocationUseCase.swift
//  WeatherAppTests
//
//  Created by Mohamed Fawzy on 24/03/2025.
//

import Foundation
@testable import WeatherApp

class MockGetCurrentLocationUseCase: GetCurrentLocationUseCase {
    var mockLocation: Location?
    var shouldThrowError = false
    var errorToThrow: Error = NSError(domain: "test", code: 0)
    
    var executeCalled = false
    var startMonitoringCalled = false
    var stopMonitoringCalled = false
    var lastDelegate: LocationUpdateDelegate?
    
    func execute() async throws -> Location {
        executeCalled = true
        
        if shouldThrowError {
            throw errorToThrow
        }
        
        guard let location = mockLocation else {
            throw NSError(domain: "test", code: 0, userInfo: [NSLocalizedDescriptionKey: "No mock location"])
        }
        
        return location
    }
    
    override func startMonitoring(delegate: LocationUpdateDelegate) {
        startMonitoringCalled = true
        lastDelegate = delegate
        super.startMonitoring(delegate: delegate)
    }
    
    override func stopMonitoring() {
        stopMonitoringCalled = true
        super.stopMonitoring()
    }
}
