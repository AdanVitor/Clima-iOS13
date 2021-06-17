//
//  WeatherEndpoint.swift
//  Clima
//
//  Created by Adan on 13/06/21.
//

import Foundation
import NetworkLibrary

class WeatherEndPoints{
    
    private let weatherBaseURL = "api.openweathermap.org/data/2.5/weather"
    
    func fetchCityWeatherEndPoint(city : String,
                                  temperatureUnit : UnitTemperature,
                                  apiKey : String,
                                  languageCode : LanguageCode) -> EndPoint{
        return EndPoint(baseUrl: weatherBaseURL,
                        queryItemsAsDictionary:
                            ["q" : city,
                             "units" : WeatherTemperatureOption.from(unitTemperature: temperatureUnit).rawValue,
                             "appid" : apiKey,
                             "lang" : languageCode.rawValue
                            ])
    }
    
    func fetchWeatherFromLocationEndPoint(latitude : Double,
                                          longitude: Double,
                                          temperatureUnit : UnitTemperature,
                                          apiKey : String,
                                          languageCode : LanguageCode) -> EndPoint{
        return EndPoint(baseUrl: weatherBaseURL,
                        queryItemsAsDictionary:
                            ["lat" : String(latitude),
                             "lon" : String(longitude),
                             "units" : WeatherTemperatureOption.from(unitTemperature: temperatureUnit).rawValue,
                             "appid" : apiKey,
                             "lang" : languageCode.rawValue
                            ])
    }
    
}


