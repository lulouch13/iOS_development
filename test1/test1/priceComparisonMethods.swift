//
//  priceComparisonMethods.swift
//  test1
//
//  Created by lulouch on 10/29/16.
//  Copyright © 2016 lulouch. All rights reserved.
//

import Foundation

class priceComparisonMethods {
    
    // function used to calculate the unit price
    func changeToUnitPrice() -> (Double, String) {
        let currentIndexPathRow = PriceDB.priceList.count - 1
        
        let (currentCurrency, currentPrice, currentAmount, currentUnit) = PriceDB.priceList[currentIndexPathRow]
        let (standardCurrency, price, amount, standardUnit) = PriceDB.priceList[0]
    
        let currentCurrencyRate = CurrencyDB.currencyList[currentCurrency]
        let standardCurrencyRate = CurrencyDB.currencyList[standardCurrency]
        
        let currentUnitRate = UnitDB.unitList[currentUnit]
        let standardUnitRate = UnitDB.unitList[standardUnit]
        
        var currentStandardUnitPrice = (currentPrice / Double(currentAmount)) * (currentCurrencyRate! / standardCurrencyRate!) * (currentUnitRate! / standardUnitRate!)
        currentStandardUnitPrice = round(currentStandardUnitPrice * 10) / 10
        let currency_unit : String = currentCurrency + "/" + currentUnit
        
        return (currentStandardUnitPrice, currency_unit)
    }
    
    // function used to get the smallest unit price
    func priceComparison() -> Int {
        // Find the lowest unit price in the unitPriceList
        if(PriceDB.unitPriceList != nil) {
            let minUnitPrice : Double = PriceDB.unitPriceList.min()!
            let cellIndex = PriceDB.unitPriceList.index(of: minUnitPrice)!
            return cellIndex
        }
        else {
            return -1
        }
    }
    
    // compare the price with the selected currency and unit
    func standardPriceComparison() -> Int {
        return 0
    }
}
