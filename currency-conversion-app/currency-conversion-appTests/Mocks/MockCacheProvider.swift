//
//  MockCacheProvider.swift
//  currency-conversion-appTests
//
//  Created by Karana Singla on 31/10/24.
//

import Foundation
@testable import currency_conversion_app

class MockCacheProvider: CacheProvider {
    private var storage = [String: Data]()
    
    func set<T: Codable>(_ value: T, forKey key: String) {
        let data = try? JSONEncoder().encode(value)
        storage[key] = data
    }
    
    func get<T: Codable>(forKey key: String) -> T? {
        guard let data = storage[key] else { return nil }
        return try? JSONDecoder().decode(T.self, from: data)
    }
}
