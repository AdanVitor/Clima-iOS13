//
//  ViewController.swift
//  Clima
//

import UIKit
import Combine

class WeatherViewController: UIViewController {

    // MARK: Coordinator
    weak var coordinator : WheaterViewCoordinator?
    
    // MARK: Loading View
    private var weatherView : WeatherView { view as! WeatherView}
    override func loadView() {
        view = WeatherView()
    }
    
    var test : Cancellable!
    override func viewDidLoad() {
        super.viewDidLoad()
        test = WeatherAPIService.shared.fetchWeather(city: City(name: "Sao Jose dos Campos",
                                                                temperatureUnit: .celsius))
            .sink(receiveCompletion: {completion in
                print(completion)
            }, receiveValue: { weatherResponse in
                print(weatherResponse)
                
            })
    }


}

