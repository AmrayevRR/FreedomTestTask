//
//  CellAction.swift
//  FreedomTestTask
//
//  Created by Ramir Amrayev on 27.08.2023.
//

import UIKit

enum CellAction: Hashable {
    case didSelect
    case custom(String)
    
    var hash: Int {
        switch self {
        case .didSelect: return 0
        case .custom(let custom):
            return custom.hashValue
        }
    }
}

struct CellActionEventData {
    let action: CellAction
    let cell: UIView
}

extension CellAction {
    static let notificationName = NSNotification.Name(rawValue: "CellAction")
    
    func invoke(cell: UIView) {
        NotificationCenter.default.post(name: CellAction.notificationName, object: nil, userInfo: ["data": CellActionEventData(action: self, cell: cell)])
    }
}
