//
//  ConfigurableCell.swift
//  FreedomTestTask
//
//  Created by Ramir Amrayev on 27.08.2023.
//

import Foundation

protocol ConfigurableCell {
    associatedtype DataType
    static var reuseIdentifier: String { get }
    func configureCell(data: DataType)
}

extension ConfigurableCell {
    static var reuseIdentifier: String { return String(describing: Self.self) }
}
