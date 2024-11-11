//
//  MockAPIClient.swift
//  currency-conversion-appTests
//
//  Created by Karana Singla on 30/10/24.
//

import Foundation
@testable import currency_conversion_app

class MockAPIClient: APIClient {
    // Flag to determine if an error should be thrown
    var shouldThrowError = false
    
    // Mock data to return as the response
    var mockResponseData: Data?
    
    // Error type to be thrown when shouldThrowError is set to true
    var errorType: APIError = .unknownError

    // Executes the mock API request, either returning mock data or throwing an error
    func execute<T: Decodable>(_ request: URLRequest) async throws -> T {
        if shouldThrowError {
            throw errorType  // Throw specified error type
        }
        
        // Ensure mock data is available, else throw a decoding error
        guard let data = mockResponseData else {
            throw APIError.decodingError("No mock data provided")
        }
        
        // Attempt to decode the mock data as the expected type
        do {
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            throw APIError.decodingError("Failed to decode data: \(error.localizedDescription)")
        }
    }
}
