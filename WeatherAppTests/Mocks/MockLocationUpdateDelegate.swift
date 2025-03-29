//
//  MockLocationUpdateDelegate.swift
//  WeatherAppTests
//
//  Created by Mohamed Fawzy on 24/03/2025.
//

import Foundation
@testable import WeatherApp

class MockLocationUpdateDelegate: LocationUpdateDelegate {
    var lastLocation: Location?
    var lastError: Error?
    
    func didUpdateLocation(_ location: Location) {
        lastLocation = location
    }
    
    func didFailWithError(_ error: Error) {
        lastError = error
    }
}
