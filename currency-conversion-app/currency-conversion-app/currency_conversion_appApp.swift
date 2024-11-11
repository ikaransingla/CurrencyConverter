//
//  currency_conversion_appApp.swift
//  currency-conversion-app
//
//  Created by Karana Singla on 30/10/24.
//

import SwiftUI

@main
struct currency_conversion_appApp: App {
    private let appContainer = AppContainer()

    var body: some Scene {
        WindowGroup {
            NavigationView {
                // Resolve CurrencyListViewModel from the container
                let viewModel = appContainer.container.resolve(CurrencyListViewModel.self)!
                CurrencyListView(viewModel: viewModel)
            }
        }
    }
}
