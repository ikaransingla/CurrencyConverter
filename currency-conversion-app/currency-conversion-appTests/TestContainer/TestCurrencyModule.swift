//
//  TestCurrencyModule.swift
//  currency-conversion-appTests
//
//  Created by Karana Singla on 30/10/24.
//

import Swinject
@testable import currency_conversion_app

class TestCurrencyModule {
    static func register(container: Container) {
        container.register(CurrencyService.self) { _ in
            MockCurrencyService()
        }
        
        container.register(CurrencyListViewModel.self) { (resolver, currencyService: CurrencyService) in
            let cacheProvider = resolver.resolve(CacheProvider.self)!
            return CurrencyListViewModel(currencyService: currencyService, cacheProvider: cacheProvider)
        }
    }
}
