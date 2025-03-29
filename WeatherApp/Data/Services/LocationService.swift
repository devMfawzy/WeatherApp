//
//  LocationService.swift
//  WeatherApp
//
//  Created by Mohamed Fawzy on 21/03/2025.
//

import Foundation
import CoreLocation

class LocationService: NSObject, LocationServiceProtocol {
    weak var delegate: LocationServiceDelegate?
    
    private let locationManager = CLLocationManager()
    private var isAwaitingPermission = false
    
    override init() {
        super.init()
        setupLocationManager()
    }
    
    private func setupLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
    }
    
    // MARK: - LocationService Protocol Implementation
    
    func startMonitoringLocation() {
        let authorizationStatus = checkAuthorizationStatus()
        
        switch authorizationStatus {
        case .authorizedWhenInUse, .authorizedAlways:
            locationManager.startUpdatingLocation()
            
        case .notDetermined:
            isAwaitingPermission = true
            locationManager.requestWhenInUseAuthorization()
            
        case .denied, .restricted:
            delegate?.locationService(self, didFailWithError: LocationError.permissionDenied)
            
        @unknown default:
            delegate?.locationService(self, didFailWithError: LocationError.unknown)
        }
    }
    
    func stopMonitoringLocation() {
        locationManager.stopUpdatingLocation()
    }
    
    deinit {
        stopMonitoringLocation()
    }
    
    // MARK: - Private Methods
    
    private func checkAuthorizationStatus() -> CLAuthorizationStatus {
        locationManager.authorizationStatus
    }
    
    private func handleLocationUpdate(_ location: CLLocation) {
        let domainLocation = Location(
            latitude: location.coordinate.latitude,
            longitude: location.coordinate.longitude
        )
        
        // Notify delegate for continuous monitoring
        delegate?.locationService(self, didUpdateLocation: domainLocation)
    }
    
    private func handleError(_ error: Error) {
        delegate?.locationService(self, didFailWithError: error)
    }
}

enum LocationError: Error {
    case permissionDenied
    case locationNotFound
    case unknown
    
    var localizedDescription: String {
        switch self {
        case .permissionDenied:
            return "Location access denied. Please enable location permissions in Settings to get weather for your current location."
        case .locationNotFound:
            return "Unable to determine your current location."
        case .unknown:
            return "An unknown error occurred while trying to access your location."
        }
    }
}

// MARK: - CLLocationManagerDelegate

extension LocationService: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        handleLocationUpdate(location)
        manager.stopUpdatingLocation()
        isAwaitingPermission = false
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        handleError(error)
        manager.stopUpdatingLocation()
        isAwaitingPermission = false
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        guard isAwaitingPermission else { return }
        let wasAwaitingPermission = isAwaitingPermission
        
        switch status {
        case .authorizedWhenInUse, .authorizedAlways:
            if wasAwaitingPermission {
                locationManager.startUpdatingLocation()
                isAwaitingPermission = false
            }
        case .denied, .restricted:
            if wasAwaitingPermission {
                handleError(LocationError.permissionDenied)
            }
        default:
            break
        }
    }
}

protocol LocationServiceDelegate: AnyObject {
    func locationService(_ service: LocationServiceProtocol, didUpdateLocation location: Location)
    func locationService(_ service: LocationServiceProtocol, didFailWithError error: Error)
}
