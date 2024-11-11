//
//  AppContainer.swift
//  currency-conversion-app
//
//  Created by Karana Singla on 30/10/24.
//

import Swinject

class AppContainer {
    let container: Container

    init() {
        container = Container()
        setupDependencies()
    }

    private func setupDependencies() {
        // Register networking-related dependencies
        NetworkingRegistration.registerDependencies(container: container)
        
        // Register cache-related dependencies
        CacheRegistration.registerDependencies(container: container)

        // Register currency-related dependencies (CurrencyService, CurrencyListViewModel)
        CurrencyModule.register(container: container)
    }
}
