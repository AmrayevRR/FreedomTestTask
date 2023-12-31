//
//  CellActionProxy.swift
//  FreedomTestTask
//
//  Created by Ramir Amrayev on 27.08.2023.
//

import UIKit

final class CellActionProxy {
    private var actions = [String: ((CellConfigurator, UIView) -> Void)]()
    
    // invoke some action and makes some notification
    func invoke(action: CellAction, cell: UIView, configurator: CellConfigurator) {
        let key = "\(action.hash)\(type(of: configurator).reuseId)"
        if let action = actions[key] {
            action(configurator, cell)
        }
    }
    
    // subscribe to cell action
    @discardableResult
    func on<CellType, DataType>(action: CellAction, handler: @escaping ((TableCellConfigurator<CellType, DataType>, CellType) -> Void)) -> Self {
        let key = "\(action.hash)\(CellType.reuseIdentifier)"
        actions[key] = { c, cell in
            handler(c as! TableCellConfigurator<CellType, DataType>, cell as! CellType)
        }
        return self
    }
}
