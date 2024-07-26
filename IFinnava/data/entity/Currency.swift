//
//  Currency.swift
//  IFinnava
//
//  Created by furkan sakız on 25.07.2024.
//

import Foundation

class Currency: Codable {
    let fromCurrencyCode: String?
    let fromCurrencyName: String?
    let toCurrencyCode: String?
    let toCurrencyName: String?
    let exchangeRate: Double?

    enum CodingKeys: String, CodingKey {
        case fromCurrencyCode = "1. From_Currency Code"
        case fromCurrencyName = "2. From_Currency Name"
        case toCurrencyCode = "3. To_Currency Code"
        case toCurrencyName = "4. To_Currency Name"
        case exchangeRate = "5. Exchange Rate"
    }

    init(fromCurrencyCode: String, fromCurrencyName: String, toCurrencyCode: String, toCurrencyName: String, exchangeRate: Double) {
        self.fromCurrencyCode = fromCurrencyCode
        self.fromCurrencyName = fromCurrencyName
        self.toCurrencyCode = toCurrencyCode
        self.toCurrencyName = toCurrencyName
        self.exchangeRate = exchangeRate
    }
}
