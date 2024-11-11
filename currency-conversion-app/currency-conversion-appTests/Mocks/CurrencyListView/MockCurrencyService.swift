//
//  MockCurrencyService.swift
//  currency-conversion-appTests
//
//  Created by Karana Singla on 30/10/24.
//

import Foundation
@testable import currency_conversion_app

class MockCurrencyService: CurrencyService {
    // Properties to control responses
    var mockExchangeRates: [String: Double] = ["USD": 1.0, "EUR": 0.85]
    var mockCurrencies: [String: String] = [
        "USD": "United States Dollar",
        "EUR": "Euro"
    ]
    var shouldThrowError = false
    
    // Simulate the fetchExchangeRates method
    func fetchExchangeRates() async throws -> ExchangeRateResponse {
        if shouldThrowError {
            throw NSError(domain: "MockCurrencyServiceError", code: -1, userInfo: [NSLocalizedDescriptionKey: "Mock error in fetchExchangeRates"])
        }
        
        // Return mock data wrapped in ExchangeRateResponse
        return ExchangeRateResponse(rates: mockExchangeRates)
    }
    
    // Simulate the fetchCurrencies method
    func fetchCurrencies() async throws -> [String: String] {
        if shouldThrowError {
            throw NSError(domain: "MockCurrencyServiceError", code: -1, userInfo: [NSLocalizedDescriptionKey: "Mock error in fetchCurrencies"])
        }
        
        // Return the mock currencies dictionary
        return mockCurrencies
    }
    
    // Helper method to reset the mock data
    func reset() {
        mockExchangeRates = ["USD": 1.0, "EUR": 0.85]
        mockCurrencies = ["USD": "United States Dollar", "EUR": "Euro"]
        shouldThrowError = false
    }
}
