//
//  APPersonsViewController.swift
//  Architectural Patterns
//
//  Created by Vladimir Goncharov on 09/07/2017.
//  Copyright © 2017 Vladimir. All rights reserved.
//

import UIKit
import SwinjectStoryboard

class APPersonsViewController: UIViewController, APPersonsDisplayManagerDelegate {
    
    typealias Model = APPerson
    
    enum Segues: String {
        case detail = "showDetail"
    }
    
    //MARK: - UI
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: -
    var displayManager: APPersonsDisplayManagerProtocol! {
        didSet {
            self.displayManager.delegate = self
        }
    }
    
    private(set) var models: [Model] = [] {
        didSet {
            self.reloadTable()
        }
    }
    
    //MARK: - init, config and deinit
    func config(models: [Model]) {
        self.models = models
        self.displayManager.config(items: models)
    }
    
    //MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(didChangePointsOfPerson(notif:)),
                                               name: NSNotification.Name.init(rawValue: APPersonDidChangePoints),
                                               object: nil)
        
        self.configureView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case Segues.detail.rawValue?:
            if let indexPath = self.displayManager.tableView?.indexPathForSelectedRow {
                let controller = (segue.destination as! UINavigationController).topViewController as! APPersonViewController
                controller.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem
                controller.navigationItem.leftItemsSupplementBackButton = true
                
                let model = self.models[indexPath.row]
                controller.config(model: model)
            }
            
        default: fatalError("\(segue) not implemented")
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    //MARK: - Notifications
    func didChangePointsOfPerson(notif: Notification) {
        if  let model = notif.object as? Model,
            let index = self.models.index(of: model) {
            self.displayManager.reloadElement(index: index, animation: UITableViewRowAnimation.automatic)
        }
    }
    
    //MARK: - APPersonsDisplayManagerDelegate
    func displayManager(manager: APPersonsDisplayManagerProtocol, didTapItem: APPersonsDisplayManagerItem) {
        self.perfromDetailSegue()
    }
}

//MARK: - Updating the view
extension APPersonsViewController {
    
    func configureView() {
        self.navigationItem.title = "Persons"
        self.displayManager.tableView = self.tableView
    }
    
    func reloadTable() {
        self.displayManager?.reloadData()
    }
}

//MARK: - Routing
extension APPersonsViewController {
    func perfromDetailSegue() {
        self.performSegue(withIdentifier: Segues.detail.rawValue, sender: nil)
    }
}

//MARK: - Depedency
extension APPersonsViewController {
    class func registerDepedency() {
        SwinjectStoryboard.defaultContainer.storyboardInitCompleted(APPersonsViewController.self) { r, c in
            c.displayManager = r.resolve(APPersonsDisplayManagerProtocol.self, name: APPersonsViewController.className)
            c.config(models: r.resolve(Array<APPerson>.self, name: APPersonsViewController.className)!)
        }
        SwinjectStoryboard.defaultContainer.register(APPersonsDisplayManagerProtocol.self, name: APPersonsViewController.className) { _ in
            return APPersonsDisplayManager()
        }
        SwinjectStoryboard.defaultContainer.register(Array<APPerson>.self, name: APPersonsViewController.className) { _ in
            let persons = [
                APPerson.init(firstName: "Abe", lastName: "Eba"),
                APPerson.init(firstName: "John", lastName: "Black"),
                APPerson.init(firstName: "Sara", lastName: "Aras")
            ]
            return persons
        }
    }
}

//MARK: -
extension APPersonsViewController.Model: APPersonsDisplayManagerItem {
    
    var leftText: String? {
        return self.fullName
    }
    
    var rigthText: String? {
        return "\(self.points)"
    }
    
}
