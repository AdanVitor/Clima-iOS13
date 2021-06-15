//
//  WeatherView.swift
//  Clima
//
//  Created by Adan on 08/06/21.
//

import UIKit
import AutolayoutExtensions
import Combine

class WeatherView: UIView {
    
    // MARK: Subviews
    let containerStack = UIStackView.createStackView(
        axis: .vertical,
        spacing: 10,
        aligment: .trailing,
        distribution: .fill)
    
    let header = WeatherHeaderView()
    
    let wheaterMark = UIImageView.createImageView(image: UIImage(systemName: "")).then{
        $0.tintColor = .label
    }
    
    let temperatureLabel = UILabel().then{
        $0.setDynamicFontStyle(fontStyle: .headline, sizeToScale: 80)
    }
    
    let cityLabel = UILabel().then{
        $0.setDynamicFontStyle(fontStyle: .subheadline, sizeToScale: 30)
    }
    
    let spaceView = UIView()
    
    // MARK: Constructor
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        applyViewCode()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: API
    var searchTextPublisher : AnyPublisher<String?,Never>{
        return header.searchTextPublisherAPI
    }
    
    func update(cityWeatherViewModel : CityWeatherViewModel){
        self.cityLabel.text = cityWeatherViewModel.name
        self.temperatureLabel.text = cityWeatherViewModel.temperature
        self.wheaterMark.image = UIImage(systemName: cityWeatherViewModel.sfSymbol ?? "")
        
    }
}

extension WeatherView : ViewCodeConfiguration{
    func buildHierarchy() {
        self.setupBackgroundImage(image: UIImage(named: AssetsImagesNames.background))
        containerStack.addArrangedSubviews(views: header,
                                           wheaterMark,
                                           temperatureLabel,
                                           cityLabel,
                                           spaceView)
        self.addSubview(containerStack)
    }
    
    func setupConstraints() {
        header.leadingAnchor.constraint(equalTo: containerStack.leadingAnchor).activate()
        containerStack.constraintsForAnchoringToSafeArea(view: self, padding: 10).activate()
        wheaterMark.constraintsForSize(width: 120, height: 120).activate()
    }
}


