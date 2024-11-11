//
//  CurrencyListViewModelTests.swift
//  currency-conversion-appTests
//
//  Created by Karana Singla on 30/10/24.
//

import XCTest
@testable import currency_conversion_app

import XCTest
@testable import currency_conversion_app

class CurrencyListViewModelTests: XCTestCase {
    // Dependencies for testing
    var testContainer: TestContainer!
    var viewModel: CurrencyListViewModel!
    var mockCurrencyService: MockCurrencyService!

    override func setUp() {
        super.setUp()
        
        // Initialize the test container to inject mock dependencies
        testContainer = TestContainer()
    }

    override func tearDown() {
        // Clean up the test container and variables after each test
        testContainer = nil
        viewModel = nil
        mockCurrencyService = nil
        super.tearDown()
    }

    func testFetchCurrenciesSuccess() async {
        // Resolve the mock currency service and set up mock data
        mockCurrencyService = testContainer.container.resolve(CurrencyService.self) as? MockCurrencyService
        mockCurrencyService.mockCurrencies = [
            "USD": "United States Dollar",
            "EUR": "Euro"
        ]

        // Resolve the view model with the configured mock service
        viewModel = testContainer.container.resolve(CurrencyListViewModel.self, argument: mockCurrencyService as CurrencyService)

        // Call loadCurrencyData and verify it fetches and updates currencies correctly
        await viewModel.loadCurrencyData()
        
        XCTAssertEqual(viewModel.currencies["USD"], "United States Dollar", "Currency data should match mock response")
        XCTAssertEqual(viewModel.currencies["EUR"], "Euro", "Currency data should match mock response")
    }

    func testFetchCurrenciesFailure() async {
        // Set up the mock service to throw an error
        mockCurrencyService = testContainer.container.resolve(CurrencyService.self) as? MockCurrencyService
        mockCurrencyService.shouldThrowError = true
        
        // Resolve the view model with the error-configured mock service
        viewModel = testContainer.container.resolve(CurrencyListViewModel.self, argument: mockCurrencyService as CurrencyService)
        
        // Call loadCurrencyData and verify it sets an error when fetching fails
        await viewModel.loadCurrencyData()
        
        XCTAssertNotNil(viewModel.error, "An error should be set if fetchCurrencies fails")
    }
}
