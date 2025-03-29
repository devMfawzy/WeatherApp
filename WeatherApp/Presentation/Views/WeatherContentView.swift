//
//  WeatherContentView.swift
//  WeatherApp
//
//  Created by Mohamed Fawzy on 21/03/2025.
//

import SwiftUI

struct WeatherContentView: View {
    let weather: WeatherUIModel
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                Text(weather.cityName)
                    .font(.system(size: 32, weight: .bold))
                
                HStack {
                    AsyncImage(url: weather.iconURL) { phase in
                        if let image = phase.image {
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 80, height: 80)
                        } else {
                            ProgressView()
                                .frame(width: 80, height: 80)
                        }
                    }
                    
                    Text(weather.temperature)
                        .font(.system(size: 60))
                }
                
                Text(weather.description)
                    .font(.title2)
                
                WeatherCardView(title: "Details", content: [
                    weather.humidity,
                    weather.windSpeed
                ])
            }
            .padding()
        }
    }
}

