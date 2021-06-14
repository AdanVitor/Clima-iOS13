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
    
    // MARK: View observers
    private var cityNameForSearchObservable : Cancellable?
    
    // MARK: View model
    private let viewModel : WeatherViewModel
    
    // MARK: Constructor
    init(viewModel : WeatherViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewObservers()

    }
    
    // MARK: Setup observers
    private func setupViewObservers(){
        cityNameForSearchObservable = weatherView.searchTextPublisher.sink{[weak self] cityName in
            self?.viewModel.fetchWeather(city: cityName)
        }
    }


}

