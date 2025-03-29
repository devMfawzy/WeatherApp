//
//  SearchView.swift
//  WeatherApp
//
//  Created by Mohamed Fawzy on 18/03/2025.
//

import SwiftUI

struct SearchView: View {
    @ObservedObject var viewModel: WeatherViewModel
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationStack {
            VStack {
                TextField("Enter city name", text: $viewModel.searchQuery)
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(10)
                    .padding(.horizontal)
                
                Button(action: {
                    if !viewModel.searchQuery.isEmpty {
                        viewModel.fetchWeather(forCity: viewModel.searchQuery)
                        dismiss()
                    }
                }) {
                    Text("Search")
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .padding(.horizontal)
                }
                
                if !viewModel.recentSearches.isEmpty {
                    List {
                        Section(header: Text("Recent Searches")) {
                            ForEach(viewModel.recentSearches, id: \.self) { city in
                                Button(action: {
                                    viewModel.fetchWeather(forCity: city)
                                    dismiss()
                                }) {
                                    HStack {
                                        Image(systemName: "clock.arrow.circlepath")
                                        Text(city)
                                    }
                                }
                            }
                        }
                    }
                }
                
                Spacer()
            }
            .padding(.top)
            .navigationTitle("Search City")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
        }
    }
}
