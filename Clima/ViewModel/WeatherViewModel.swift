//
//  WeatherViewModel.swift
//  Clima
//
//  Created by Adan on 13/06/21.
//

import Foundation
import Combine

class WeatherViewModel{
    
    private let weatherApiService = WeatherAPIService.shared
    
    private var cityWeatherObservable : Cancellable?
    
    
    
    // MARK: API

    
    func fetchWeather(city : String) -> AnyPublisher<CityWeatherViewModel,Never>{
        return weatherApiService.fetchWeather(city: city)
            .map { CityWeatherViewModel(name: $0.name, temperature: $0.temperature, sfSymbol: $0.description?.rawValue) }
            .replaceError(with: CityWeatherViewModel(name: "Error to get city \(city)", temperature: nil, sfSymbol: nil))
            .setFailureType(to: Never.self)
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    

    
}
