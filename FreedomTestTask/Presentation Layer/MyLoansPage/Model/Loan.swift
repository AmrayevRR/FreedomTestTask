//
//  Loan.swift
//  FreedomTestTask
//
//  Created by Ramir Amrayev on 29.08.2023.
//

import UIKit

struct Loan {
    let title: String
    let icon: UIImage
    let amount: Decimal
    let totalPeriodsAmount: Int
    let completedPeriodsAmount: Int
    let residualAmount: Decimal
    let isSpecial: Bool
    let date: String
    let monthAmount: Decimal
}
