//
//  LocationServiceProtocol.swift
//  WeatherApp
//
//  Created by Mohamed Fawzy on 21/03/2025.
//

import Foundation

protocol LocationServiceProtocol: AnyObject {
    var delegate: LocationServiceDelegate? { get set }

    func startMonitoringLocation()
    func stopMonitoringLocation()
}
