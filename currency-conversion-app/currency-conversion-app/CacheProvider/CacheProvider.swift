//
//  CacheProvider.swift
//  currency-conversion-app
//
//  Created by Karana Singla on 31/10/24.
//

import Foundation

/// Defines a flexible caching interface, allowing various storage solutions (e.g., UserDefaults, Core Data).
/// Enables modularity and easy swapping of cache providers without impacting dependent classes.
protocol CacheProvider {
    func set<T: Codable>(_ value: T, forKey key: String)
    func get<T: Codable>(forKey key: String) -> T?
}
