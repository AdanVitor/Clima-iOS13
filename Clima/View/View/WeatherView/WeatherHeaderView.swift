//
//  WeatherHeaderView.swift
//  Clima
//
//  Created by Adan on 08/06/21.
//

import UIKit
import Combine
import AutolayoutExtensions
import CombineExtensions

class WeatherHeaderView: UIView {
    
    // MARK: Subviews
    
    private let containerStack = UIStackView.createStackView(
        axis: .horizontal,
        spacing: 5,
        aligment: .fill,
        distribution: .fill)

    private let locationSetButton = UIButton().then{
        $0.setBackgroundImage(UIImage(systemName: "location.circle.fill"),
                              for: .normal)
        $0.tintColor = .label
    }
    
    private let searchBar = UISearchBar().then{
        $0.placeholder = "Search"
        $0.searchBarStyle = .minimal
        $0.searchTextField.returnKeyType = .done
        $0.enablesReturnKeyAutomatically = false
    }
    
    // MARK: Observables
    private let searchTextObservable = PassthroughSubject<String?,Never>()
    var searchTextPublisherAPI : AnyPublisher<String?,Never>{
        return searchTextObservable.eraseToAnyPublisher()
    }
    
    var locationButtonPublisher : AnyPublisher<Void,Never>{
        return locationSetButton.actionPublisher(for: .touchUpInside)
            .map{_ in return}.eraseToAnyPublisher()
    }
    
    // MARK: Constructor
    
    init() {
        super.init(frame: .zero)
        applyViewCode()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension WeatherHeaderView : ViewCodeConfiguration{
    func buildHierarchy() {
        containerStack.addArrangedSubviews(views: locationSetButton, searchBar)
        self.addSubview(containerStack)
    }
    
    func setupConstraints() {
        containerStack.constraintsForAnchoringTo(view: self).activate()
        locationSetButton.constraintsForSize(width: 40, height: 40).activate()
    }
    
    func configureViews() {
        searchBar.delegate = self
    }
}

extension WeatherHeaderView : UISearchBarDelegate{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let searchedText = searchBar.text
        resignKeyboardAndClear(searchBar: searchBar)
        searchTextObservable.send(searchedText)
    }
    
    private func resignKeyboardAndClear(searchBar : UISearchBar){
        searchBar.resignFirstResponder()
        searchBar.text?.clear()
    }
}
