//
//  MyLoansCellBuilder.swift
//  FreedomTestTask
//
//  Created by Ramir Amrayev on 27.08.2023.
//

import Foundation

final class MyLoansCellBuilder: CellBuilder {
    var configurableCells: [CellConfigurator] = []
    
    func buildCells(myLoans: [MyLoan]) {
        for (sectionIndex, myLoan) in myLoans.enumerated() {
            addSectionTitleCell(myLoan.date)
            for (index, loan) in myLoan.loans.enumerated() {
                addLoanCell(loan: loan, sectionIndex: sectionIndex, index: index)
            }
        }
    }
}

private extension MyLoansCellBuilder {
    func addSectionTitleCell(_ title: String) {
        configurableCells.append(TitleCellConfigurator(item: title))
    }
    
    func addLoanCell(loan: Loan, sectionIndex: Int, index: Int) {
        let model = LoanCellModel(
            leftIcon: loan.icon,
            title: loan.title,
            isCheckMarkHidden: !loan.isSpecial,
            amountAttributedText: loan.amount.formattedAmountTengeColored(),
            totalTrackAmount: loan.totalPeriodsAmount,
            passedTrackAmount: loan.completedPeriodsAmount,
            bottomLeftText: "Погашено \(loan.completedPeriodsAmount) из \(loan.totalPeriodsAmount)",
            bottomRightText: "осталось \(loan.residualAmount.formattedAmountTenge())",
            backgroundColor: Color.backgroundColor,
            sectionIndex: sectionIndex,
            index: index
        )
        configurableCells.append(LoanCellConfigurator(item: model))
    }
}
