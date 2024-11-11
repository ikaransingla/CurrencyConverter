//
//  UserDefaultsCacheProvider.swift
//  currency-conversion-app
//
//  Created by Karana Singla on 31/10/24.
//

import Foundation

/// A `CacheProvider` implementation using `UserDefaults` for lightweight key-value caching of `Codable` data.
/// Suitable for simple data storage without complex relationships.
class UserDefaultsCacheProvider: CacheProvider {
    private let userDefaults: UserDefaults

    /// Initializes with a specified `UserDefaults` instance (default is `.standard`).
    init(userDefaults: UserDefaults = .standard) {
        self.userDefaults = userDefaults
    }

    /// Stores a `Codable` value in `UserDefaults` under the given key.
    func set<T: Codable>(_ value: T, forKey key: String) {
        if let data = try? JSONEncoder().encode(value) {
            userDefaults.set(data, forKey: key)
        }
    }

    /// Retrieves a `Codable` value from `UserDefaults` for the given key, or `nil` if not found.
    func get<T: Codable>(forKey key: String) -> T? {
        guard let data = userDefaults.data(forKey: key) else { return nil }
        return try? JSONDecoder().decode(T.self, from: data)
    }
}
