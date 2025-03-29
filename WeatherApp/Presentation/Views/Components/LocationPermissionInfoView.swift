//
//  LocationPermissionInfoView.swift
//  WeatherApp
//
//  Created by Mohamed Fawzy on 21/03/2025.
//

import SwiftUI

struct LocationPermissionInfoView: View {
    var onDismiss: () -> Void
    var onOpenSettings: () -> Void
    
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "location.slash.fill")
                .font(.system(size: 50))
                .foregroundColor(.blue)
                .padding()
            
            Text("Location Access Required")
                .font(.title)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
            
            Text("This app needs your location to show weather in your current area. Please enable location access in Settings.")
                .multilineTextAlignment(.center)
                .padding(.horizontal)
            
            HStack(spacing: 20) {
                Button(action: onDismiss) {
                    Text("Not Now")
                        .padding(.horizontal, 20)
                        .padding(.vertical, 10)
                        .background(Color.gray.opacity(0.2))
                        .foregroundColor(.primary)
                        .cornerRadius(10)
                }
                
                Button(action: onOpenSettings) {
                    Text("Open Settings")
                        .padding(.horizontal, 20)
                        .padding(.vertical, 10)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            }
            .padding(.top, 10)
        }
        .padding()
        .frame(maxWidth: 320)
        .background(Color.white)
        .cornerRadius(20)
        .shadow(radius: 10)
    }
}

#Preview {
    ZStack {
        Color.black.opacity(0.4)
            .ignoresSafeArea()
        
        LocationPermissionInfoView(
            onDismiss: {},
            onOpenSettings: {}
        )
    }
}
