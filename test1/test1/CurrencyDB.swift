//
//  CurrencyDB.swift
//  test1
//
//  Created by lulouch on 10/29/16.
//  Copyright © 2016 lulouch. All rights reserved.
//

import Foundation

class CurrencyDB {
    // global variable for currency list
    static let currencyList : [String : Double] =
        [
         "CNY": 1.0000,
         "USD": 6.7691,
         "HKD": 0.8742,
         "EUR": 7.3920,
         "GBP": 8.2535,
         "JPY": 0.0645,
         "KRW": 0.0060
    ]
    
    // The order on the currency table
    static let currencySignList : [String] =
        [ "USD",
          "CNY",
          "HKD",
          "EUR",
          "GBP",
          "JPY",
          "KRW" ]
    
    // Currency Sign shown on the priceTable
    static let currencySimpleSign : [String] =
        [ "$", ""]
    
}
