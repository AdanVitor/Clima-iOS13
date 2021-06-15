//
//  City.swift
//  Clima
//
//  Created by Adan on 13/06/21.
//

import Foundation

// Raw value is the sf symbol name
enum WeatherDescription : String {
    case thunderstorm = "cloud.bolt"
    case drizzle = "cloud.drizzle"
    case rain = "cloud.rain"
    case snow = "cloud.snow"
    case fog = "cloud.fog"
    case clear = "sun.max"
    case clouds = "cloud"
    
    
}

struct CityWeather{
    let name : String
    let temperature : Measurement<UnitTemperature>?
    let description : WeatherDescription?
}
