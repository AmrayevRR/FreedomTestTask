//
//  MyLoansViewModel.swift
//  FreedomTestTask
//
//  Created by Ramir Amrayev on 29.08.2023.
//

import Foundation

final class MyLoansViewModel {
    let myLoans: [MyLoan] = [
        .init(
            date: "21 апрель 2022",
            loans: [
                .init(
                    title: "Прочие займы",
                    icon: Images.account,
                    amount: 23000,
                    totalPeriodsAmount: 12,
                    completedPeriodsAmount: 4,
                    residualAmount: 8476.66,
                    isSpecial: false,
                    date: "21.04.2022",
                    monthAmount: 1059.58
                )
            ]
        ),
        .init(
            date: "2 апрель 2022",
            loans: [
                .init(
                    title: "Прочие займы",
                    icon: Images.account,
                    amount: 40805.05,
                    totalPeriodsAmount: 12,
                    completedPeriodsAmount: 4,
                    residualAmount: 8476.66,
                    isSpecial: false,
                    date: "02.04.2022",
                    monthAmount: 1059.58
                )
            ]
        ),
        .init(
            date: "23 май 2022",
            loans: [
                .init(
                    title: "Прочие займы",
                    icon: Images.account,
                    amount: 84830,
                    totalPeriodsAmount: 12,
                    completedPeriodsAmount: 4,
                    residualAmount: 8476.66,
                    isSpecial: false,
                    date: "23.05.2022",
                    monthAmount: 1059.58
                )
            ]
        ),
        .init(
            date: "13 май 2022",
            loans: [
                .init(
                    title: "Прочие займы",
                    icon: Images.account,
                    amount: 12715,
                    totalPeriodsAmount: 12,
                    completedPeriodsAmount: 1,
                    residualAmount: 1466.66,
                    isSpecial: false,
                    date: "13.05.2022",
                    monthAmount: 1059.58
                )
            ]
        ),
        .init(
            date: "11 май 2022",
            loans: [
                .init(
                    title: "Altel",
                    icon: Images.altel,
                    amount: 3000,
                    totalPeriodsAmount: 12,
                    completedPeriodsAmount: 5,
                    residualAmount: 1750,
                    isSpecial: true,
                    date: "11.05.2022",
                    monthAmount: 1059.58
                ),
                .init(
                    title: "Magnum",
                    icon: Images.magnum,
                    amount: 1500,
                    totalPeriodsAmount: 12,
                    completedPeriodsAmount: 8,
                    residualAmount: 500,
                    isSpecial: true,
                    date: "11.05.2022",
                    monthAmount: 1059.58
                )
            ]
        )
    ]
}
