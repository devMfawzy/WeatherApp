//
//  WeatherCardView.swift
//  WeatherApp
//
//  Created by Mohamed Fawzy on 18/03/2025.
//

import SwiftUI

struct WeatherCardView: View {
    let title: String
    let content: [String]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(title)
                .font(.headline)
                .padding(.bottom, 8)
            
            ForEach(content, id: \.self) { item in
                Text(item)
            }
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.white.opacity(0.2))
        .cornerRadius(12)
    }
}
