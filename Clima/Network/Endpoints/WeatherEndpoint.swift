//
//  WeatherEndpoint.swift
//  Clima
//
//  Created by Adan on 13/06/21.
//

import Foundation

class WeatherEndPoints{
    
    
    private let weatherBaseURL = "api.openweathermap.org/data/2.5/weather"
    
    func fetchCityWeatherEndPoint(city : City,
                          apiKey : String,
                          languageCode : LanguageCode) -> EndPoint{
        return EndPoint(baseUrl: weatherBaseURL,
                        queryItemsAsDictionary:
                            ["q" : city.name,
                             "units" : WeatherTemperatureOption.from(unitTemperature: city.temperatureUnit).rawValue,
                             "appid" : apiKey,
                             "lang" : languageCode.rawValue
                            ])
    }
    
}


