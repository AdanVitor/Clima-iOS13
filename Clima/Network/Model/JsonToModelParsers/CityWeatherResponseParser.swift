//
//  CityWeatherResponseParser.swift
//  Clima
//
//  Created by Adan on 15/06/21.
//

import Foundation

extension CityWeatherResponse{
    
    func toCityWeather(temperatureUnit : UnitTemperature) -> CityWeather{
        let temperature = main?.temp
        let weatherCode = weather?.first?.id
        return CityWeather(name: name,
                           temperature: temperature != nil ?
                            Measurement(value: temperature!, unit: temperatureUnit) : nil,
                           description: weatherCodeToWeatherDescription(weatherCodeOptional: weatherCode))
        
    }
    
    private func weatherCodeToWeatherDescription(weatherCodeOptional : Int?) -> WeatherDescription?{
        guard let weatherCode = weatherCodeOptional else { return nil }
        
        switch weatherCode {
            case 200...232: return .thunderstorm
            case 300...321: return .drizzle
            case 500...531: return .rain
            case 600...622: return .snow
            case 701...782: return .fog
            case 800: return .clear
            default : return .clouds
        }
    }
    
    
}
