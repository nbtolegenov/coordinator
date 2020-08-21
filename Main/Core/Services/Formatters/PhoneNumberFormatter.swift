//
//  PhoneNumberFormatter.swift
//  Coordinator
//
//  Created by Nurlan Tolegenov on 8/21/20.
//  Copyright © 2020 Nurlan Tolegenov. All rights reserved.
//

import Foundation

protocol PhoneNumberFormatter {
    func formattedPhoneNumber(from text: String) -> String?
    func rawPhoneNumber(from text: String) -> String?
    func digits(from text: String) -> String?
}

extension PropertyFormatter: PhoneNumberFormatter {
    func formattedPhoneNumber(from text: String) -> String? {
        let digits = text.unicodeScalars
            .filter { CharacterSet.decimalDigits.contains($0) }
            .map { String($0) }
        guard digits.count <= Constants.digitsCount else { return nil }

        var formattedString = "+"
        for (index, digit) in digits.enumerated() {
            switch index {
            case 1:
                formattedString += " (\(digit)"
            case 3:
                formattedString += "\(digit)) "
            case 7, 9:
                formattedString += " \(digit)"
            default:
                formattedString += "\(digit)"
            }
        }
        return formattedString
    }

    func rawPhoneNumber(from text: String) -> String? {
        guard let digits = digits(from: text) else { return nil }
        return "+\(digits)"
    }

    func digits(from text: String) -> String? {
        let digits = text.unicodeScalars
            .filter { CharacterSet.decimalDigits.contains($0) }
            .map { String($0) }
            .joined()
        guard digits.count <= Constants.digitsCount else { return nil }
        return digits
    }
}

private enum Constants {
    static let digitsCount = 11
}
