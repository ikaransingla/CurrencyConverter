//
//  CurrencyService.swift
//  currency-conversion-app
//
//  Created by Karana Singla on 30/10/24.
//

import Foundation
protocol CurrencyService {
    // Fetches exchange rates data from the API
    func fetchExchangeRates() async throws -> ExchangeRateResponse
    
    // Fetches list of available currencies from the API
    func fetchCurrencies() async throws -> [String: String]
}

class CurrencyServiceImpl: CurrencyService {
    private let apiClient: APIClient
    private let requestBuilder: WebRequestBuilder
    
    // Initializes service with dependencies for making API requests
    init(apiClient: APIClient,
         requestBuilder: WebRequestBuilder) {
        self.apiClient = apiClient
        self.requestBuilder = requestBuilder
    }
    
    // Builds and executes request to fetch exchange rates
    func fetchExchangeRates() async throws -> ExchangeRateResponse {
        let request = requestBuilder
            .setPath("/api/latest.json")
            .setMethod("GET")
            .addQueryItem(name: "app_id", value: "ee7ba0c895944ba68547aedc88e80761")
            .build()
        
        guard let urlRequest = request else {
            throw APIError.invalidURL
        }
        
        return try await apiClient.execute(urlRequest)
    }
    
    // Builds and executes request to fetch list of currencies
    func fetchCurrencies() async throws -> [String: String] {
        let request = requestBuilder
            .setPath("/api/currencies.json")
            .setMethod("GET")
            .addQueryItem(name: "app_id", value: "ee7ba0c895944ba68547aedc88e80761")
            .build()
        
        guard let urlRequest = request else {
            throw APIError.invalidURL
        }
        
        let response: [String: String] = try await apiClient.execute(urlRequest)
        return response
    }
    
}

