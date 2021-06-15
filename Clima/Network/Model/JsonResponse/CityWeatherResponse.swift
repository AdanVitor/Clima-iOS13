//
//  CityWeatherResponse.swift
//  Clima
//
//  Created by Adan on 13/06/21.
//

import Foundation

struct CityWeatherResponse : Codable{
    let name : String
    let main : TemperatureResponse?
    let weather : [WeatherDescriptionResponse]?
}

struct TemperatureResponse : Codable {
    let temp: Double
    let feels_like: Double
    let temp_min: Double
    let temp_max: Double
    let pressure: Double
    let humidity: Double
}

struct WeatherDescriptionResponse : Codable{
    let id : Int
    let main : String
    let description : String
}
