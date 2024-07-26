//
//  CurrencyResponse.swift
//  IFinnava
//
//  Created by furkan sakız on 25.07.2024.
//

import Foundation

class CurrencyResponse: Codable {
    var currency: [Currency]?
    
    enum CodingKeys: String, CodingKey {
        case currency = "Realtime Currency Exchange Rate"
    }
}
