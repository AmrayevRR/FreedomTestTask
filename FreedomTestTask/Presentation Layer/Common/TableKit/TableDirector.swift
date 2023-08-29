//
//  TableDirector.swift
//  FreedomTestTask
//
//  Created by Ramir Amrayev on 27.08.2023.
//

import UIKit
import Combine

final class TableDirector: NSObject {
    
    private let tableView: UITableView
    private var items = [CellConfigurator]() {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    let actionProxy = CellActionProxy()
    
    init(tableView: UITableView, items: [CellConfigurator]) {
        tableView.separatorStyle = .none
        self.tableView = tableView
        super.init()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.items = items
        
        NotificationCenter.default.addObserver(self, selector: #selector(onActionEvent(notification:)), name: CellAction.notificationName, object: nil)
    }
    
    @objc private func onActionEvent(notification: Notification) {
        if let eventData = notification.userInfo?["data"] as? CellActionEventData, let cell = eventData.cell as? UITableViewCell, let indexPath = self.tableView.indexPath(for: cell) {
            actionProxy.invoke(action: eventData.action, cell: cell, configurator: self.items[indexPath.row])
        }
    }
    
    func reloadTable(with cellItems: [CellConfigurator]) {
        self.items = cellItems
    }
}

// MARK: - UITableViewDelegate
extension TableDirector: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cellConfig = self.items[indexPath.row]
        tableView.deselectRow(at: indexPath, animated: true)
        guard let cell = tableView.cellForRow(at: indexPath) else {
            return
        }
        self.actionProxy.invoke(action: .didSelect, cell: cell, configurator: cellConfig)
    }
}


// MARK: - UITableViewDataSource
extension TableDirector: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.items.count > 0 ? 1 : 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellConfig = self.items[indexPath.row]
        tableView.register(type(of: cellConfig).cellClass, forCellReuseIdentifier: type(of:cellConfig).reuseId)
        let cell = tableView.dequeueReusableCell(withIdentifier: type(of: cellConfig).reuseId, for: indexPath)
        cellConfig.configureCell(cell: cell)
        return cell
    }
}
