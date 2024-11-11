//
//  CurrencyListViewModel.swift
//  currency-conversion-app
//
//  Created by Karana Singla on 30/10/24.
//

import SwiftUI

class CurrencyListViewModel: ObservableObject {
    // Published properties to store fetched exchange rates, currencies, loading state, and errors
    @Published var exchangeRates: [String: Double] = [:]
    @Published var currencies: [String: String] = [:]
    @Published var loading: Bool = false
    @Published var error: String? = nil

    // Published properties for the amount to convert and selected currency
    @Published var amount: Double? = 0.0
    @Published var selectedCurrency: String = "USD"

    // Dependencies for fetching data and caching
    private let currencyService: CurrencyService
    private let cacheProvider: CacheProvider

    // Cache keys and fetch interval (30 minutes)
    private let cacheKeyRates = "cachedExchangeRates"
    private let cacheKeyCurrencies = "cachedCurrencies"
    private let cacheKeyLastFetchDate = "lastFetchDate"
    private let cacheInterval: TimeInterval = 30 * 60

    // Initializer loads cached data and sets dependencies
    init(currencyService: CurrencyService, cacheProvider: CacheProvider) {
        self.currencyService = currencyService
        self.cacheProvider = cacheProvider
        loadCachedData()
    }

    // Loads currency data, either from API or cache based on fetch interval
    @MainActor
    func loadCurrencyData() async {
        if shouldFetchFromAPI() {
            await fetchCurrencyDataFromAPI()
        }
    }

    // Checks if the API should be called based on the last fetch date and interval
    private func shouldFetchFromAPI() -> Bool {
        if let lastFetchDate: Date = cacheProvider.get(forKey: cacheKeyLastFetchDate) {
            return Date().timeIntervalSince(lastFetchDate) > cacheInterval
        }
        return true
    }

    // Fetches exchange rates and currency list from API, updates properties, and caches results
    @MainActor
    private func fetchCurrencyDataFromAPI() async {
        loading = true
        error = nil

        do {
            // Fetch exchange rates first
            let exchangeRatesResponse = try await currencyService.fetchExchangeRates()
            self.exchangeRates = exchangeRatesResponse.rates

            // Then fetch currencies
            let currenciesResponse = try await currencyService.fetchCurrencies()
            self.currencies = currenciesResponse

            self.loading = false

            // Cache the fetched data after both calls succeed
            cacheData(exchangeRates: exchangeRatesResponse.rates, currencies: currenciesResponse)
        } catch {
            // Handle any errors by setting the error property
            self.error = error.localizedDescription
            self.loading = false
        }
    }

    // Caches exchange rates, currencies, and the last fetch date
    private func cacheData(exchangeRates: [String: Double], currencies: [String: String]) {
        cacheProvider.set(exchangeRates, forKey: cacheKeyRates)
        cacheProvider.set(currencies, forKey: cacheKeyCurrencies)
        cacheProvider.set(Date(), forKey: cacheKeyLastFetchDate)
    }

    // Loads exchange rates and currencies from cache if available
    private func loadCachedData() {
        if let cachedRates: [String: Double] = cacheProvider.get(forKey: cacheKeyRates),
           let cachedCurrencies: [String: String] = cacheProvider.get(forKey: cacheKeyCurrencies) {
            self.exchangeRates = cachedRates
            self.currencies = cachedCurrencies
        }
    }

    // Computes converted exchange rates based on selected currency and amount
    var convertedExchangeRates: [String: Double] {
        guard let amount = amount, amount >= 0, let baseRate = exchangeRates[selectedCurrency] else {
            return exchangeRates
        }
        return exchangeRates.mapValues { ($0 / baseRate) * amount }
    }
}

