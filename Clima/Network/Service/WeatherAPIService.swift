//
//  WeatherAPIService.swift
//  Clima
//
//  Created by Adan on 13/06/21.
//

import Foundation
import Combine
import NetworkLibrary

class WeatherAPIService{
    
    static let shared = WeatherAPIService()
    private init () {}
    
    private let apiKey = "16e465f2129ed0419bbe7fc70a460f81"
    private let languageCode = LanguageCode.portugueseBr
    
    private let weatherEndPoints = WeatherEndPoints()
    
    private static let temperatureUnit = UnitTemperature.celsius
    
    func fetchWeather(city : String) -> AnyPublisher<CityWeather,Error>{
        return weatherEndPoints
            .fetchCityWeatherEndPoint(city: city,temperatureUnit: WeatherAPIService.temperatureUnit, apiKey: apiKey, languageCode: languageCode)
            .createURLRequest(httpMethod: .GET)
            .fetchJsonPublisher(jsonType: CityWeatherResponse.self)
            .map{ jsonResponse in
                let temperature = jsonResponse.main?.temp
                return CityWeather(name: jsonResponse.name,
                                   temperature: temperature != nil ? Measurement(value: temperature!, unit: WeatherAPIService.temperatureUnit) : nil)
            }.eraseToAnyPublisher()
        
    }
}
