//
//  APPersonsDisplayManagerProtocol.swift
//  Architectural Patterns
//
//  Created by Vladimir Goncharov on 09/07/2017.
//  Copyright © 2017 Vladimir. All rights reserved.
//

import UIKit

protocol APPersonsDisplayManagerItem: NSObjectProtocol {
    var leftText: String? { get }
    var rigthText: String? { get }
}

protocol APPersonsDisplayManagerDelegate: NSObjectProtocol {
    func displayManager(manager: APPersonsDisplayManagerProtocol, didTapItem: APPersonsDisplayManagerItem)
}

protocol APPersonsDisplayManagerProtocol: NSObjectProtocol, UITableViewDelegate, UITableViewDataSource {
    weak var delegate: APPersonsDisplayManagerDelegate? { get set }
    weak var tableView: UITableView? { get set }
    
    var items: [APPersonsDisplayManagerItem] { get }
    func config(items: [APPersonsDisplayManagerItem])
    
    func reloadData()

    func insertElement(item: APPersonsDisplayManagerItem, index: Int, animation: UITableViewRowAnimation)
    func deleteElement(index: Int, animation: UITableViewRowAnimation)
    func reloadElement(index: Int, animation: UITableViewRowAnimation)
    func moveElement(fromIndex: Int, toIndex: Int, animation: UITableViewRowAnimation)
    func performBatchUpdates(_ updates: (() -> Swift.Void)?) // allows multiple insert/delete/reload/move calls to be animated simultaneously. Nestable.
    
}
