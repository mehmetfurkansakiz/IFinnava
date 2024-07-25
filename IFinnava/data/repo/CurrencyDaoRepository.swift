//
//  CurrencyDaoRepository.swift
//  IFinnava
//
//  Created by furkan sakız on 25.07.2024.
//

import Foundation
import RxSwift
import Alamofire

class CurrencyDaoRepository {
    var currencyList = BehaviorSubject<[Currency]>(value: [Currency]())
        
        private let apiKey = "U5Q6K7LCK20653H1"
        
//        func getCurrencies() {
//            let currencies = [
//                ("USD", "JPY"),
//                ("BTC", "EUR"),
//                ("USD", "EUR"),
//                ("GBP", "USD"),
//                ("AUD", "CAD")
//            ]
//            
//            var exchangeRates = [Currency]()
//            
//            let dispatchGroup = DispatchGroup()
//            
//            for (fromCurrency, toCurrency) in currencies {
//                dispatchGroup.enter()
//                
//                let url = "https://www.alphavantage.co/query"
//                let parameters: Parameters = [
//                    "function": "CURRENCY_EXCHANGE_RATE",
//                    "from_currency": fromCurrency,
//                    "to_currency": toCurrency,
//                    "apikey": apiKey
//                ]
//                
//                AF.request(url, parameters: parameters).response { response in
//                    if let data = response.data {
//                        do {
//                            
//                            let res = try JSONDecoder().decode(CurrencyResponse.self, from: data)
//                            print(res)
//                            if let currency = res.currency {
//                                exchangeRates.append(contentsOf: currency)
//                            }
//                        } catch {
//                            print("Error decoding: \(error.localizedDescription)")
//                        }
//                    }
//                    dispatchGroup.leave()
//                }
//            }
//            
//            dispatchGroup.notify(queue: .main) {
//                self.currencyList.onNext(exchangeRates)
//            }
//        }
    
    func getCurrencies() {
        
        let staticCurrencies = [
            Currency(fromCurrencyCode: "USD", fromCurrencyName: "United States Dollar", toCurrencyCode: "JPY", toCurrencyName: "Japanese Yen", exchangeRate: 110.50),
            Currency(fromCurrencyCode: "BTC", fromCurrencyName: "Bitcoin", toCurrencyCode: "EUR", toCurrencyName: "Euro", exchangeRate: 60489.21),
            Currency(fromCurrencyCode: "USD", fromCurrencyName: "United States Dollar", toCurrencyCode: "EUR", toCurrencyName: "Euro", exchangeRate: 0.8475),
            Currency(fromCurrencyCode: "GBP", fromCurrencyName: "British Pound", toCurrencyCode: "USD", toCurrencyName: "United States Dollar", exchangeRate: 1.3900),
            Currency(fromCurrencyCode: "AUD", fromCurrencyName: "Australian Dollar", toCurrencyCode: "CAD", toCurrencyName: "Canadian Dollar", exchangeRate: 0.93)
        ]
        
        self.currencyList.onNext(staticCurrencies)
    }
}
