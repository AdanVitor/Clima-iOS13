//
//  WeatherViewPreview.swift
//  Clima
//
//  Created by Adan on 09/06/21.
//



//
//  MainViewRepresentable.swift
//  Dicee-iOS13
//
//  Created by Adan on 20/05/21.

//

import Foundation

#if canImport(SwiftUI) && DEBUG
import SwiftUI
struct WeatherViewControllerSwiftUI: UIViewRepresentable {
    func makeUIView(context: Context) -> UIView {
        return WeatherViewController(viewModel: WeatherViewModel()).view
    }
    
    func updateUIView(_ view: UIView, context: Context) {
    }
}

@available(iOS 13.0, *)
struct WeatherViewController_Preview: PreviewProvider {
    static var previews: some View {
        WeatherViewControllerSwiftUI()
            .preferredColorScheme(.dark)
    }
}
#endif

