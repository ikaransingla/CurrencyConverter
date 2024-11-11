//
//  APIError.swift
//  currency-conversion-app
//
//  Created by Karana Singla on 30/10/24.
//

enum APIError: Error {
    case invalidURL
    case networkError(String)
    case decodingError(String) 
    case unknownError
}
