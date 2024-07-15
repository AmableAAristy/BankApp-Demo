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
    func isValidBirthday() -> Bool {
        let regex = try! NSRegularExpression(pattern: "^(0[1-9]|1[0-2])[/-](0[1-9]|[12][0-9]|3[01])[/-](\\d{4}|\\d{2})$",
                                             options: .caseInsensitive)
        return regex.firstMatch(in: self, range: NSRange(location: 0, length: count)) != nil
    }
    func isValidPhoneNumber() -> Bool {
        let regex = try! NSRegularExpression(pattern: "^(\\+\\d{1,2}\\s?)?1?\\-?\\.?\\(?(\\d{3})\\)?\\-?\\.?\\s?(\\d{3})\\-?\\.?\\s?(\\d{4})$",
                                             options: .caseInsensitive)
        return regex.firstMatch(in: self, range: NSRange(location: 0, length: count)) != nil
    }
    
    func isValidDouble() -> Bool {
        let regex = try! NSRegularExpression(pattern: "^[0-9]+(\\.[0-9]{0,2})?$", options: .caseInsensitive)
        return regex.firstMatch(in: self, range: NSRange(location: 0, length: self.utf16.count)) != nil
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

