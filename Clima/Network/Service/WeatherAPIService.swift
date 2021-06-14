//
//  WeatherAPIService.swift
//  Clima
//
//  Created by Adan on 13/06/21.
//

import Foundation
import Combine

class WeatherAPIService{
    
    static let shared = WeatherAPIService()
    private init () {}
    
    private let apiKey = "16e465f2129ed0419bbe7fc70a460f81"
    private let languageCode = LanguageCode.portugueseBr
    
    private let weatherEndPoints = WeatherEndPoints()
    
    func fetchWeather(city : City) -> AnyPublisher<CityWeatherResponse,Error>{
        return weatherEndPoints
            .fetchCityWeatherEndPoint(city: city,apiKey: apiKey,languageCode: languageCode)
            .createURLRequest(httpMethod: .GET)
            .fetchJsonPublisher(jsonType: CityWeatherResponse.self)
    }
}
