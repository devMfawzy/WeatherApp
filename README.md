# WeatherApp

WeatherApp is a SwiftUI application that follows the principles of Clean Architecture. This architecture separates concerns into distinct layers, making the codebase more maintainable, testable, and scalable.

For a detailed explanation of the implementation, you can refer to the [Clean Architecture in SwiftUI article on Medium](https://medium.com/@mo.fawzy/clean-architecture-in-swiftui-4eb33a187cdc) story.

## Core Principles of Clean Architecture

### Separation of Layers

1. **Domain Layer**: This layer contains the business logic, entities, and use cases of the application.
2. **Data Layer**: This layer includes repositories and data sources.
3. **Presentation Layer**: This layer is responsible for the UI components and ViewModels.

### Dependency Rule

- Dependencies only point inward. Outer layers depend on inner layers, but not vice versa.

## Project Structure
```
WeatherApp/
├── Domain/
│   ├── Entities/
│   │   ├── Location.swift
│   │   └── Weather.swift
│   ├── RepositoryInterfaces/
│   │   ├── WeatherRepositoryProtocol.swift
│   │   └── SearchHistoryRepositoryProtocol.swift
│   ├── Services/
│   │   └── LocationServiceProtocol.swift
│   └── UseCases/
│       ├── GetWeatherUseCase.swift
│       ├── GetCurrentLocationUseCase.swift
│       └── ManageSearchHistoryUseCase.swift
├── Data/
│   ├── Repositories/
│   │   ├── WeatherRepository.swift
│   │   └── SearchHistoryRepository
│   ├── DataSources/
│   │   ├── Remote/
│   │   │   └── WeatherRemoteDataSource.swift
│   │   └── Local/
│   │       ├── SearchHistoryLocalDataSource.swift
│   │       └── WeatherLocalDataSource.swift
│   ├── Services/
│   │   └── LocationService.swift
│   └── Models/
│       └── WeatherResponseDTO.swift
│       └── WeatherLocal.Swift
└── Presentation/
    ├── Views/
    │   ├── WeatherView.swift
    │   ├── WeatherContentView.swift
    │   ├── SearchView.swift
    │   └── Components/
    │       ├── WeatherCardView.swift
    │       ├── ErrorView.swift
    │       ├── LocationPermissionInfoView.swift
    │       └── LoadingView.swift
    ├── ViewModels/
    │   └── WeatherViewModel.swift
    └── UIModels/
        └── WeatherUIModel.swift
```

### Installation

1. Clone the repository:
    ```sh
    git clone https://github.com/devMfawzy/WeatherApp.git
    ```
2. Open the project in Xcode:
    ```sh
    cd WeatherApp
    open WeatherApp.xcodeproj
    ```

### Running the App

1. Build and run the project in Xcode.
2. The app should launch in the iOS Simulator or on a physical device.

## Acknowledgements

- Special thanks to Uncle Bob Martin for the concept of Clean Architecture.
