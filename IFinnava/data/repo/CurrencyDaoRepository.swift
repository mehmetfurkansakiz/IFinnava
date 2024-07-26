//
//  CurrencyDaoRepository.swift
//  IFinnava
//
//  Created by furkan sakız on 25.07.2024.
//

import Alamofire
import Foundation
import RxSwift

class CurrencyDaoRepository {
    var currencyList = BehaviorSubject<[Currency]>(value: [Currency]())
        
    private let apiKey = "U5Q6K7LCK20653H1"
    private let useMockService = true
    
    func getCurrencies() {
        if useMockService {
            getMockCurrencies()
        } else {
            getAPICurrencies()
        }
    }
    
    private func getAPICurrencies() {
        let currencies = [
            ("USD", "JPY"),
            ("BTC", "EUR"),
            ("USD", "EUR"),
            ("GBP", "USD"),
            ("AUD", "CAD")
        ]
        
        var exchangeRates = [Currency]()
        let dispatchGroup = DispatchGroup()
        
        for (fromCurrency, toCurrency) in currencies {
            dispatchGroup.enter()
            
            let url = "https://www.alphavantage.co/query"
            let parameters: Parameters = [
                "function": "CURRENCY_EXCHANGE_RATE",
                "from_currency": fromCurrency,
                "to_currency": toCurrency,
                "apikey": apiKey
            ]
            
            AF.request(url, parameters: parameters).response { response in
                if let data = response.data {
                    do {
                        let res = try JSONDecoder().decode(CurrencyResponse.self, from: data)
                        print(res)
                        if let currency = res.currency {
                            exchangeRates.append(contentsOf: currency)
                        }
                    } catch {
                        print("Error decoding: \(error.localizedDescription)")
                    }
                }
                dispatchGroup.leave()
            }
        }
        
        dispatchGroup.notify(queue: .main) {
            self.currencyList.onNext(exchangeRates)
        }
    }
    
    private func getMockCurrencies() {
        let staticCurrencies = [
            Currency(fromCurrencyCode: "USD", fromCurrencyName: "United States Dollar", toCurrencyCode: "JPY", toCurrencyName: "Japanese Yen", exchangeRate: 110.50),
            Currency(fromCurrencyCode: "BTC", fromCurrencyName: "Bitcoin", toCurrencyCode: "EUR", toCurrencyName: "Euro", exchangeRate: 60489.21),
            Currency(fromCurrencyCode: "USD", fromCurrencyName: "United States Dollar", toCurrencyCode: "EUR", toCurrencyName: "Euro", exchangeRate: 0.8475),
            Currency(fromCurrencyCode: "GBP", fromCurrencyName: "British Pound", toCurrencyCode: "USD", toCurrencyName: "United States Dollar", exchangeRate: 1.3900),
            Currency(fromCurrencyCode: "AUD", fromCurrencyName: "Australian Dollar", toCurrencyCode: "CAD", toCurrencyName: "Canadian Dollar", exchangeRate: 0.93),
            Currency(fromCurrencyCode: "CAD", fromCurrencyName: "Canadian Dollar", toCurrencyCode: "CHF", toCurrencyName: "Swiss Franc", exchangeRate: 0.68),
            Currency(fromCurrencyCode: "JPY", fromCurrencyName: "Japanese Yen", toCurrencyCode: "GBP", toCurrencyName: "British Pound", exchangeRate: 0.0067),
            Currency(fromCurrencyCode: "EUR", fromCurrencyName: "Euro", toCurrencyCode: "AUD", toCurrencyName: "Australian Dollar", exchangeRate: 1.6200),
            Currency(fromCurrencyCode: "CHF", fromCurrencyName: "Swiss Franc", toCurrencyCode: "JPY", toCurrencyName: "Japanese Yen", exchangeRate: 150.00),
            Currency(fromCurrencyCode: "CNY", fromCurrencyName: "Chinese Yuan", toCurrencyCode: "USD", toCurrencyName: "United States Dollar", exchangeRate: 0.1450),
            Currency(fromCurrencyCode: "KRW", fromCurrencyName: "South Korean Won", toCurrencyCode: "EUR", toCurrencyName: "Euro", exchangeRate: 0.0007),
            Currency(fromCurrencyCode: "NZD", fromCurrencyName: "New Zealand Dollar", toCurrencyCode: "GBP", toCurrencyName: "British Pound", exchangeRate: 0.4850),
            Currency(fromCurrencyCode: "SEK", fromCurrencyName: "Swedish Krona", toCurrencyCode: "CHF", toCurrencyName: "Swiss Franc", exchangeRate: 0.0950),
            Currency(fromCurrencyCode: "SGD", fromCurrencyName: "Singapore Dollar", toCurrencyCode: "USD", toCurrencyName: "United States Dollar", exchangeRate: 0.7380),
            Currency(fromCurrencyCode: "MXN", fromCurrencyName: "Mexican Peso", toCurrencyCode: "JPY", toCurrencyName: "Japanese Yen", exchangeRate: 5.57),
            Currency(fromCurrencyCode: "RUB", fromCurrencyName: "Russian Ruble", toCurrencyCode: "EUR", toCurrencyName: "Euro", exchangeRate: 0.011),
            Currency(fromCurrencyCode: "TRY", fromCurrencyName: "Turkish Lira", toCurrencyCode: "USD", toCurrencyName: "United States Dollar", exchangeRate: 0.037),
            Currency(fromCurrencyCode: "ZAR", fromCurrencyName: "South African Rand", toCurrencyCode: "GBP", toCurrencyName: "British Pound", exchangeRate: 0.050)
        ]
        
        currencyList.onNext(staticCurrencies)
    }
}
