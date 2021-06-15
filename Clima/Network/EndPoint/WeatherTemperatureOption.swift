//
//  WeatherTemperatureOptions.swift
//  Clima
//
//  Created by Adan on 13/06/21.
//

import Foundation

enum WeatherTemperatureOption : String{
    case standard
    case metric
    case imperial
    
    static func from(unitTemperature : UnitTemperature) -> WeatherTemperatureOption{
        switch unitTemperature {
            case .celsius: return .metric
            case .fahrenheit : return .imperial
            default: return .standard
        }
    }
}




