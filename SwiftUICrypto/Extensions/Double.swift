//
//  Double.swift
//  SwiftUICrypto
//
//  Created by saul on 6/8/24.
//

import Foundation

extension Double {
    private var currencyFormatter: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.usesGroupingSeparator = true
        formatter.numberStyle = .currency
        formatter.locale = .current
        formatter.currencyCode = "usd"
        formatter.currencySymbol = "$"
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        return formatter
    }

    /// Converts a Double into a  Currency as a String with 2 decimals places
    /// ```
    /// convert 1234.5678 to "$1,234.56"
    /// convert 12.3456 to "$12.34"
    /// convert 0.15225 to "$0.15"
    /// ```
    func asCurrencyWithDecimals() -> String {
        let number = NSNumber(value: self)
        return currencyFormatter.string(from: number) ?? "$0.00"
    }

    /// Converts a Double into a String representation
    /// ```
    /// convert 1234.5678 to "1234.56"
    /// convert 12.3456 to "12.34"
    /// convert 0.15225 to "0.15"
    /// ```
    func asNumberString() -> String {
        return String(format: "%.2f", self)
    }

    /// Converts a Double into a String representation with percent symbol
    /// ```
    /// convert 1234.5678 to "1234.56%"
    /// convert 12.3456 to "12.34%"
    /// convert 0.15225 to "0.15%"
    /// ```
    func asPercentString() -> String {
        return asNumberString() + "%"
    }
}
