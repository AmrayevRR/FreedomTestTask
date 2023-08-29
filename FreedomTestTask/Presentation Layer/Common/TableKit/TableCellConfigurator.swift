//
//  TableCellConfigurator.swift
//  FreedomTestTask
//
//  Created by Ramir Amrayev on 27.08.2023.
//

import UIKit

final class TableCellConfigurator<CellType: ConfigurableCell, DataType>: CellConfigurator where CellType.DataType == DataType, CellType: UITableViewCell {
    
    static var reuseId: String { return CellType.reuseIdentifier }
    static var cellClass: AnyClass { return CellType.self }
    
    let item: DataType
    
    init(item: DataType) {
        self.item = item
    }
    
    func configureCell(cell: UIView) {
        (cell as! CellType).configureCell(data: item)
    }
    
}
