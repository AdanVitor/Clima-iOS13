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
    
    func fetchWeather(city : String?){
        
        guard let cityName = city else { return }
        
        cityWeatherObservable = weatherApiService
            .fetchWeather(city: City(name: cityName,temperatureUnit: .celsius)).sink(
                receiveCompletion: { completion in
                    switch(completion){
                        case .failure(let error):
                            print("Error: \(error)")
                        case .finished:
                            print("Observer is finished")
                    }
                    
                },
                receiveValue: { weatherResponse in
                    print(weatherResponse)
                    
                })
    }
    
}
