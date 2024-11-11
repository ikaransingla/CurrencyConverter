//
//  WebRequestBuilderImpl.swift
//  currency-conversion-app
//
//  Created by Karana Singla on 30/10/24.
//

import Foundation
class WebRequestBuilderImpl: WebRequestBuilder {
    private var urlComponents: URLComponents
    private var httpMethod: String = "GET"
    private var headers: [String: String] = [:]
    private var body: Data?

    init(baseURL: String) {
        self.urlComponents = URLComponents(string: baseURL)!
    }

    func setPath(_ path: String) -> Self {
        urlComponents.path = path
        return self
    }

    func addQueryItem(name: String, value: String?) -> Self {
        var queryItems = urlComponents.queryItems ?? []
        queryItems.append(URLQueryItem(name: name, value: value))
        urlComponents.queryItems = queryItems
        return self
    }

    func setMethod(_ method: String) -> Self {
        self.httpMethod = method
        return self
    }

    func addHeader(field: String, value: String) -> Self {
        headers[field] = value
        return self
    }

    func setBody(_ body: Data?) -> Self {
        self.body = body
        return self
    }

    func build() -> URLRequest? {
        guard let url = urlComponents.url else { return nil }
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod
        request.allHTTPHeaderFields = headers
        request.httpBody = body
        return request
    }
}
