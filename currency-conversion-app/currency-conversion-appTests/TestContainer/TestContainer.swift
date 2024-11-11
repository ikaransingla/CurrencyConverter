//
//  TestContainer.swift
//  currency-conversion-appTests
//
//  Created by Karana Singla on 30/10/24.
//

import Swinject
@testable import currency_conversion_app

class TestContainer {
    let container: Container

    init() {
        container = Container()

        // Register MockAPIClient for APIClient protocol
        container.register(APIClient.self) { _ in
            MockAPIClient()
        }

        // Register other mock implementations as needed
        container.register(CacheProvider.self) { _ in
            MockCacheProvider()
        }

        TestCurrencyModule.register(container: container)
    }
}
