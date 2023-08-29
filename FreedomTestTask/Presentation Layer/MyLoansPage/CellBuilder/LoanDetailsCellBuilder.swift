//
//  LoanDetailsCellBuilder.swift
//  FreedomTestTask
//
//  Created by Ramir Amrayev on 29.08.2023.
//

import Foundation

final class LoanDetailsCellBuilder: CellBuilder {
    var configurableCells: [CellConfigurator] = []
    
    func buildCells(loan: Loan) {
        configurableCells = []
        addLoanCell(loan: loan)
        addLeftRightTextCell(loan: loan)
        addButtonCell()
    }
}

private extension LoanDetailsCellBuilder {
    func addLoanCell(loan: Loan) {
        let model = LoanCellModel(
            leftIcon: loan.icon,
            title: loan.title,
            isCheckMarkHidden: !loan.isSpecial,
            amountAttributedText: loan.amount.formattedAmountTengeColored(),
            totalTrackAmount: loan.totalPeriodsAmount,
            passedTrackAmount: loan.completedPeriodsAmount,
            bottomLeftText: "Погашено \(loan.completedPeriodsAmount) из \(loan.totalPeriodsAmount)",
            bottomRightText: "осталось \(loan.residualAmount.formattedAmountTenge())",
            backgroundColor: Color.drawerBackgroundColor
        )
        configurableCells.append(LoanCellConfigurator(item: model))
    }
    
    func addLeftRightTextCell(loan: Loan) {
        let format = NSLocalizedString("month_count", comment: "")
        let model: [LeftRightTextRowModel] = [
            .init(leftText: "Дата совершения покупки", rightText: loan.date),
            .init(leftText: "Сумма займа", rightTextAttributed: loan.amount.formattedAmountTengeColored()),
            .init(leftText: "Срок займа", rightText: String.localizedStringWithFormat(format, loan.totalPeriodsAmount)),
            .init(leftText: "Eжемесячный платеж", rightTextAttributed: loan.monthAmount.formattedAmountTengeColored())
        ]
        configurableCells.append(LeftRightTextCellConfigurator(item: model))
    }
    
    func addButtonCell() {
        configurableCells.append(ButtonCellConfigurator(item: "Подробнее о тратах"))
    }
}
