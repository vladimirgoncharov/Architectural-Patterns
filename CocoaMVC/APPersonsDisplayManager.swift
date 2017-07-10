//
//  APPersonsDisplayManager.swift
//  Architectural Patterns
//
//  Created by Vladimir Goncharov on 09/07/2017.
//  Copyright © 2017 Vladimir. All rights reserved.
//

import UIKit

class APPersonsDisplayManager: NSObject, APPersonsDisplayManagerProtocol {

    weak var delegate: APPersonsDisplayManagerDelegate?
    weak var tableView: UITableView? {
        didSet {
            if let tableView = self.tableView {
                tableView.delegate = self
                tableView.dataSource = self
                tableView.register(APPersonTableViewCell.getNib(), forCellReuseIdentifier: APPersonTableViewCell.className)
                self.reloadData()
            }
        }
    }
    private(set) var items: [APPersonsDisplayManagerItem] = []
    
    //MARK: - APPersonsDisplayManagerProtocol
    func config(items: [APPersonsDisplayManagerItem]) {
        self.items = items
        self.reloadData()
    }
    
    func reloadData() {
        self.tableView?.reloadData()
    }
    
    func insertElement(item: APPersonsDisplayManagerItem, index: Int, animation: UITableViewRowAnimation) {
        self.items.insert(item, at: index)
        self.tableView?.insertRows(at: [IndexPath(row: index, section: 0)],
                                   with: animation)
    }
    
    func deleteElement(index: Int, animation: UITableViewRowAnimation = .none) {
        self.items.remove(at: index)
        self.tableView?.deleteRows(at: [IndexPath(row: index, section: 0)],
                                   with: animation)
    }
    
    func reloadElement(index: Int, animation: UITableViewRowAnimation = .none) {
        self.tableView?.reloadRows(at: [IndexPath(row: index, section: 0)],
                                   with: animation)
    }
    
    func moveElement(fromIndex: Int, toIndex: Int, animation: UITableViewRowAnimation = .none) {
        swap(&self.items[fromIndex], &self.items[toIndex])
        self.tableView?.reloadRows(at: [IndexPath(row: fromIndex, section: 0), IndexPath(row: toIndex, section: 0)],
                                   with: animation)
    }
    
    func performBatchUpdates(_ updates: (() -> Swift.Void)?) {
        if let tableView = self.tableView {
            tableView.beginUpdates()
            updates?()
            tableView.endUpdates()
        }
    }
    
    //MARK: - UITableViewDataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = self.items[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: APPersonTableViewCell.className, for: indexPath)
        cell.textLabel?.text = item.leftText
        cell.detailTextLabel?.text = item.rigthText
        return cell
    }
    
    //MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = self.items[indexPath.row]
        self.delegate?.displayManager(manager: self, didTapItem: item)
    }
}
