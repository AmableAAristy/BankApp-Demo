//
//  String.swift
//  LoginApp
//
//  Created by Amable A Aristy  on 6/23/24.
//

import Foundation

extension String {
    
    func isValidEmail() -> Bool{
        let regex = try! NSRegularExpression(pattern: "^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,}$",
                                             options: .caseInsensitive )
        return regex.firstMatch(in: self, range: NSRange(location: 0, length: count)) != nil
    }
    
}
extension NumberFormatter {
    static var currency: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencySymbol = "$"
        formatter.maximumFractionDigits = 2
        return formatter
    }
}

