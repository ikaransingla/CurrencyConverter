//
//  APIClient.swift
//  currency-conversion-app
//
//  Created by Karana Singla on 30/10/24.
//

import Foundation

protocol APIClient {
    func execute<T: Decodable>(_ request: URLRequest) async throws -> T
}

class APIClientImpl: APIClient {
    func execute<T: Decodable>(_ request: URLRequest) async throws -> T {
        let (data, _) = try await URLSession.shared.data(for: request)
        return try JSONDecoder().decode(T.self, from: data)
    }
}
