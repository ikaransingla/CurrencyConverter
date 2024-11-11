//
//  CurrencyListRegistration.swift
//  currency-conversion-app
//
//  Created by Karana Singla on 30/10/24.
//

import Swinject

class CurrencyModule {
    static func register(container: Container) {
        container.register(CurrencyService.self) { resolver in
            let apiClient = resolver.resolve(APIClient.self)!
            let requestBuilder = resolver.resolve(WebRequestBuilder.self)!
            
            return CurrencyServiceImpl(apiClient: apiClient, requestBuilder: requestBuilder)
        }

        container.register(CurrencyListViewModel.self) { resolver in
            let currencyService = resolver.resolve(CurrencyService.self)!
            let cacheProvider = resolver.resolve(CacheProvider.self)!

            return CurrencyListViewModel(currencyService: currencyService, 
                                         cacheProvider: cacheProvider)
        }
    }
}
