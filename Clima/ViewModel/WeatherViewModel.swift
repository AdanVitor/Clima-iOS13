//
//  WeatherViewModel.swift
//  Clima
//
//  Created by Adan on 13/06/21.
//

import Foundation
import Combine
import CoreLocation

class WeatherViewModel : NSObject{
    
    private let weatherApiService = WeatherAPIService.shared
    private let locationManager = CLLocationManager()
    private var locationDelegatePublisher = LocationDelegatePublisher()
    
    // MARK: API
    
    override init() {
        super.init()
        self.locationManager.delegate = locationDelegatePublisher
        
    }
    
    func fetchWeatherFromUserLocation() -> AnyPublisher<CityWeatherViewModel,Never> {
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        return locationDelegatePublisher.locationPublisher.flatMap{[weak self] location -> AnyPublisher<CityWeatherViewModel,Never> in
            guard let self = self else { return Just(CityWeatherViewModel(name: "Error to get location data", temperature: nil, sfSymbol: nil)).eraseToAnyPublisher()}
            let latitude = location.coordinate.latitude
            let longitude = location.coordinate.longitude
            let weatherAPIPublisher = self.weatherApiService.fetchWeatherFromLocation(latitude: latitude, longitude: longitude)
            return self.applyViewModelOperations(weatherApiPublisher: weatherAPIPublisher,errorMessage: "Error to get location")
        }.eraseToAnyPublisher()
    }
    
    func fetchWeather(city : String) -> AnyPublisher<CityWeatherViewModel,Never>{
        return applyViewModelOperations(weatherApiPublisher: weatherApiService.fetchWeather(city: city) ,
                                        errorMessage: "Error to get city \(city)")
    }
    
    private func applyViewModelOperations(weatherApiPublisher : AnyPublisher<CityWeather,Error>, errorMessage: String) -> AnyPublisher<CityWeatherViewModel,Never> {
        return weatherApiPublisher
            .map { CityWeatherViewModel(name: $0.name, temperature: $0.temperature, sfSymbol: $0.description?.rawValue) }
            .replaceError(with: CityWeatherViewModel(name: errorMessage, temperature: nil, sfSymbol: nil))
            .setFailureType(to: Never.self)
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
        
    }
}

private class LocationDelegatePublisher : NSObject, CLLocationManagerDelegate{
    
    private let locationSubject = PassthroughSubject<CLLocation, Never>()
    var locationPublisher : AnyPublisher<CLLocation, Never>{
        return locationSubject.eraseToAnyPublisher()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        locationSubject.send(location)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
    
}
