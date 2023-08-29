//
//  CellBuilder.swift
//  FreedomTestTask
//
//  Created by Ramir Amrayev on 27.08.2023.
//

import Foundation

protocol CellBuilder {
    var configurableCells: [CellConfigurator] {
        get set
    }
}
