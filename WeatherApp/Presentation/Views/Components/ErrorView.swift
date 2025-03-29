//
//  ErrorView.swift
//  WeatherApp
//
//  Created by Mohamed Fawzy on 18/03/2025.
//

import SwiftUI

struct ErrorView<T: StringProtocol>: View {
    let message: T
    let onDismiss: () -> Void
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Button(action: onDismiss) {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.gray)
                        .padding()
                }
            }
            
            Image(systemName: "exclamationmark.triangle")
                .font(.system(size: 50))
                .foregroundColor(.red)
                .padding()
            
            Text("Error")
                .font(.title)
                .fontWeight(.bold)
                .padding(.bottom, 8)
            
            Text(message)
                .font(.body)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
                .padding(.bottom)
            
            Button(action: onDismiss) {
                Text("Dismiss")
                    .padding(.horizontal, 30)
                    .padding(.vertical, 12)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding(.bottom)
        }
        .frame(width: UIScreen.main.bounds.width * 0.8)
        .background(Color.white)
        .cornerRadius(20)
        .shadow(radius: 10)
    }
}
