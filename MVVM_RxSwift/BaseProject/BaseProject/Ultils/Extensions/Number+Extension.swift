//
//  Number+Extension.swift
//  AB Branded App
//
//  Created by Nguyen Van Tu on 12/26/17.
//  Copyright © 2017 Lucio Pham. All rights reserved.
//

import Foundation

extension Double
{
    func toString() -> String
    {
        if (self == floor(self)) {
            return String(format:"%d", Int(self))
        } else {
            return "\(self)"
        }
        
    }
    func toKilometer() -> Double
    {
        return self/1000.0
    }
    func toKilometerString() -> String
    {
        return String(format: "%.2f", self.toKilometer())
    }
    func secondsToHoursMinutesSeconds () -> (Int, Int, Int) {
        return (Int(self) / 3600, (Int(self) % 3600) / 60, (Int(self) % 3600) % 60)
    }
    func currencyString(currencyCode: String = Store.currentStore?.currencyCode ?? "USD") -> String
    {
        let currencyFormatter = NumberFormatter()
        currencyFormatter.numberStyle = .currency
        currencyFormatter.currencyCode = currencyCode
        currencyFormatter.minimumFractionDigits = 0
        currencyFormatter.maximumFractionDigits = 2
        currencyFormatter.negativeFormat = "-¤#,##0.00"
        
        return currencyFormatter.string(from: NSNumber(value: self))!
    }
}

extension Int
{
    func toString() -> String
    {
        return "\(self)"
    }
    
}
