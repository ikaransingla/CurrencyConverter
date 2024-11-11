//
//  NetworkingRegistrations.swift
//  currency-conversion-app
//
//  Created by Karana Singla on 30/10/24.
//

import Swinject

class NetworkingRegistration {
    static func registerDependencies(container: Container) {
        container.register(APIClient.self) { _ in
            APIClientImpl()
        }
        
        container.register(WebRequestBuilder.self) { _ in
            WebRequestBuilderImpl(baseURL: "https://openexchangerates.org")
        }
    }
}
