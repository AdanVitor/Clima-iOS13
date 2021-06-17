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
    private let locationDelegatePublisher : LocationDelegatePublisher
    
    // MARK: API
    
    override init() {
        self.locationDelegatePublisher = LocationDelegatePublisher(locationManager: self.locationManager)
        super.init()
    }
    
    func fetchWeatherFromUserLocation() -> AnyPublisher<CityWeatherViewModel,Never> {
        
        return locationDelegatePublisher.requestLocationPublisher().flatMap{[weak self] location -> AnyPublisher<CityWeatherViewModel,Never> in
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
   
    private weak var locationManager : CLLocationManager?
    
    init(locationManager : CLLocationManager){
        super.init()
        self.locationManager = locationManager
        self.locationManager?.delegate = self
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        manager.stopUpdatingLocation()
        locationSubject.send(location)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
    
    func requestLocationPublisher() -> AnyPublisher<CLLocation,Never>{
        requestLocationAccessIfIsNeeded()
        self.locationManager?.requestLocation()
        return locationSubject.eraseToAnyPublisher()
    }
    
    private func requestLocationAccessIfIsNeeded(){
        switch CLLocationManager.authorizationStatus() {
            case .authorizedAlways, .authorizedWhenInUse:
                break
            default:
                locationManager?.requestWhenInUseAuthorization()
        }
    }
    
}
