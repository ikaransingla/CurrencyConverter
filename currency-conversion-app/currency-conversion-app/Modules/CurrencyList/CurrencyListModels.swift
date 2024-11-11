//
//  CurrencyListModels.swift
//  currency-conversion-app
//
//  Created by Karana Singla on 30/10/24.
//

import Foundation
struct ExchangeRateResponse: Decodable {
    let rates: [String: Double]
}
