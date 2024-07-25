//
//  CurrencyViewModel.swift
//  IFinnava
//
//  Created by furkan sakız on 25.07.2024.
//

import Foundation
import RxSwift
import UIKit

class CurrencyViewModel {
    
    var currencyRepo = CurrencyDaoRepository()
    var currencyList = BehaviorSubject<[Currency]>(value: [Currency]())
    
    init() {
        currencyList = currencyRepo.currencyList
    }
    
    func getCurrencies() {
        currencyRepo.getCurrencies()
    }
}
