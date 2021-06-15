//
//  CityWeatherViewModel.swift
//  Clima
//
//  Created by Adan on 14/06/21.
//

import Foundation

struct CityWeatherViewModel{
    let name : String
    let temperature : String
    let sfSymbol : String?
    
    init(name : String, temperature : Measurement<UnitTemperature>?, sfSymbol : String?){
        self.name = name
        self.temperature = CityWeatherViewModel.temperatureFormatted(temperatureOptional: temperature)
        self.sfSymbol = sfSymbol
    }
    
    private static func temperatureFormatted(temperatureOptional : Measurement<UnitTemperature>?) -> String{
        guard let temperature = temperatureOptional else { return "Data not available" }
        let tempFormatter = MeasurementFormatter()
        tempFormatter.locale = Locale.init(identifier: "pt_BR")
        tempFormatter.numberFormatter.maximumFractionDigits = 0
        return tempFormatter.string(from: temperature)
    }
}
