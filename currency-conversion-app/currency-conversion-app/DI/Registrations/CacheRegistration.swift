//
//  CacheRegistration.swift
//  currency-conversion-app
//
//  Created by Karana Singla on 31/10/24.
//

import Swinject

class CacheRegistration {
    static func registerDependencies(container: Container) {
        container.register(CacheProvider.self) { _ in
            UserDefaultsCacheProvider()
        }
    }
}
