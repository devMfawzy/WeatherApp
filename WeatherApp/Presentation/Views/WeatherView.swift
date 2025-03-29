//
//  WeatherView.swift
//  WeatherApp
//
//  Created by Mohamed Fawzy on 18/03/2025.
//

import SwiftUI

// Presentation/Views/WeatherView.swift

import SwiftUI

struct WeatherView: View {
    @StateObject var viewModel: WeatherViewModel
    @State private var showSearch = false
    @Environment(\.openURL) private var openURL
    
    var body: some View {
        ZStack {
            // Background gradient
            LinearGradient(
                gradient: Gradient(colors: [Color.blue.opacity(0.5), Color.blue.opacity(0.2)]),
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()
            
            if viewModel.isLoading {
                LoadingView()
            } else if let weather = viewModel.weatherUIModel {
                WeatherContentView(weather: weather)
            } else {
                VStack {
                    Text("Weather")
                        .font(.largeTitle)
                        .padding()
                    
                    Button(action: {
                        viewModel.fetchWeatherForCurrentLocation()
                    }) {
                        Label("Get Weather for My Location", systemImage: "location.fill")
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    
                    Button(action: {
                        showSearch = true
                    }) {
                        Label("Search for a City", systemImage: "magnifyingglass")
                            .padding()
                            .background(Color.green)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    .padding(.top)
                }
            }
            
            if viewModel.showLocationPermissionInfo {
                Color.black.opacity(0.4)
                    .ignoresSafeArea()
                    .overlay(
                        LocationPermissionInfoView(
                            onDismiss: {
                                viewModel.showLocationPermissionInfo = false
                            },
                            onOpenSettings: {
                                openSettings()
                                viewModel.showLocationPermissionInfo = false
                            }
                        )
                    )
            }
        }
        .sheet(isPresented: $showSearch) {
            SearchView(viewModel: viewModel)
        }
        .alert(
            "Error",
            isPresented: .init(
                get: { viewModel.errorMessage != nil },
                set: { if !$0 { viewModel.errorMessage = nil } }
            ),
            actions: {
                Button("OK", role: .cancel) {
                    viewModel.errorMessage = nil
                }
            },
            message: {
                if let errorMessage = viewModel.errorMessage {
                    Text(errorMessage)
                } else {
                    Text("An unknown error occurred")
                }
            }
        )
        .toolbar {
            if viewModel.weatherUIModel != nil {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        viewModel.refreshWeather()
                    }) {
                        Image(systemName: "arrow.clockwise")
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        showSearch = true
                    }) {
                        Image(systemName: "magnifyingglass")
                    }
                }
            }
        }
    }
    
    private func openSettings() {
        if let settingsURL = URL(string: UIApplication.openSettingsURLString) {
            openURL(settingsURL)
        }
    }
}
