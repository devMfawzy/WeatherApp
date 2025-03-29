//
//  WeatherAppApp.swift
//  WeatherApp
//
//  Created by Mohamed Fawzy on 18/03/2025.
//

import SwiftUI

@main
struct WeatherApp: App {
    let dependencies = DependencyContainer()

    var body: some Scene {
        WindowGroup {
            NavigationStack {
                WeatherView(viewModel: dependencies.makeWeatherViewModel())
            }
        }
    }
}
