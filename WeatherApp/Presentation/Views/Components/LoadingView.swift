//
//  LoadingView.swift
//  WeatherApp
//
//  Created by Mohamed Fawzy on 18/03/2025.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        VStack {
            ProgressView()
                .scaleEffect(1.5)
                .padding()
            
            Text("Loading weather data...")
                .font(.headline)
        }
    }
}
