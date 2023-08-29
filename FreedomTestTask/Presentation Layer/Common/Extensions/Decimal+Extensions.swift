//
//  Decimal+Extensions.swift
//  FreedomTestTask
//
//  Created by Ramir Amrayev on 28.08.2023.
//

import Foundation

private extension Decimal {
    func formattedAmount() -> String {
        let formatter = NumberFormatter()
        formatter.groupingSeparator = " "
        formatter.decimalSeparator = ","
        formatter.maximumFractionDigits = 2
        formatter.minimumFractionDigits = 0
        formatter.numberStyle = .decimal
        return formatter.string(from: NSDecimalNumber(decimal: self)) ?? "\(self)"
    }
}

extension Decimal {
    func formattedAmountTenge() -> String {
        return formattedAmount() + " ₸"
    }
    
    func formattedAmountTengeColored() -> NSAttributedString {
        let mainText = formattedAmountTenge()
        let mainTextArr = mainText.components(separatedBy: ",")
        let mutableAttributedString = NSMutableAttributedString.init(string: mainText)
        if mainTextArr.count == 2 {
            let coloredTextRange = (mainText as NSString).range(of: mainTextArr[1])
            
            mutableAttributedString.addAttribute(
                NSAttributedString.Key.foregroundColor,
                value: Color.textGray,
                range: coloredTextRange
            )
        }
        return mutableAttributedString
    }
}
