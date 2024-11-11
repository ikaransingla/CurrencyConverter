//
//  WebRequestBuilder.swift
//  currency-conversion-app
//
//  Created by Karana Singla on 30/10/24.
//

import Foundation
protocol WebRequestBuilder {
    func setPath(_ path: String) -> Self
    func addQueryItem(name: String, value: String?) -> Self
    func setMethod(_ method: String) -> Self
    func addHeader(field: String, value: String) -> Self
    func setBody(_ body: Data?) -> Self
    func build() -> URLRequest?
}
