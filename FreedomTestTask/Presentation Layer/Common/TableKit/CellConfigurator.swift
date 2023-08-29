//
//  CellConfigurator.swift
//  FreedomTestTask
//
//  Created by Ramir Amrayev on 27.08.2023.
//

import Foundation

import UIKit

protocol CellConfigurator {
    static var reuseId: String { get }
    static var cellClass: AnyClass { get }
    func configureCell(cell: UIView)
}
