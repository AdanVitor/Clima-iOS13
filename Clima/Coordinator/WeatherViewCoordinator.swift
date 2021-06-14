//
//  WeatherViewCoordinator.swift
//  Clima
//
//  Created by Adan on 08/06/21.
//

import Foundation
import UIKit

class WheaterViewCoordinator : Coordinator{
    
    let rootVC : UINavigationController
    
    init(rootVC : UINavigationController) {
        self.rootVC = rootVC
        self.rootVC.navigationBar.isHidden = true
    }
    
    func start() {
        let weatherVC = WeatherViewController(viewModel: WeatherViewModel())
        weatherVC.coordinator = self
        rootVC.pushViewController(weatherVC, animated: true)
    }
}
