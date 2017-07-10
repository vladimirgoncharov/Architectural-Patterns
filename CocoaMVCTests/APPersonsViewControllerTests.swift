//
//  APPersonsViewControllerTests.swift
//  Architectural Patterns
//
//  Created by Vladimir Goncharov on 09/07/2017.
//  Copyright © 2017 Vladimir. All rights reserved.
//

import XCTest
import SwinjectStoryboard
@testable import CocoaMVC

class APPersonsViewControllerTests: XCTestCase {
    
    var instance: APPersonsViewController!
    
    override func setUp() {
        super.setUp()
        
        APPersonsViewControllerTests.registerTestsDepedency()
        
        self.instance = SwinjectStoryboard.create(name: "Main", bundle: nil, container: SwinjectStoryboard.defaultContainer).instantiateViewController(withIdentifier: APPersonsViewController.className) as! APPersonsViewController
        XCTAssertNotNil(self.instance.view)
        XCTAssertNotNil(self.instance.displayManager)
        XCTAssertNotNil(self.instance.displayManager.tableView)
        XCTAssertNotNil(self.instance.displayManager.delegate)
        XCTAssert(self.instance.models.count == 4, "For \(String.init(describing: #selector(getter: APPersonsViewController.models))) test data not enjected")
    }
    
    override func tearDown() {
        self.instance = nil
        super.tearDown()
    }
    
    class func registerTestsDepedency() {
        SwinjectStoryboard.defaultContainer.register(Array<APPerson>.self, name: APPersonsViewController.className) { _ in
            let persons = [
                APPerson.init(firstName: "Test 1", lastName: "Test 1"),
                APPerson.init(firstName: "Test 2", lastName: "Test 2"),
                APPerson.init(firstName: "Test 3", lastName: "Test 3"),
                APPerson.init(firstName: "Test 4", lastName: "Test 4"),
                ]
            return persons
        }
    }
    
    //MARK: - Tests
    func testDetailSegue() {
        self.instance.displayManager.tableView?.selectRow(at: IndexPath(row: 0, section: 0),
                                                          animated: true,
                                                          scrollPosition: UITableViewScrollPosition.none)
        self.instance.perfromDetailSegue()
    }
    
    func testDisplayManager() {
        var itemsCount = self.instance.displayManager.items.count
        var tableElementsCount = self.instance.displayManager.tableView!.numberOfRows(inSection: 0)
        
        //insert element
        let newPerson = APPersonsViewController.Model(firstName: "New", lastName: "Wen")
        var newPersonIndex = 0
        self.instance.displayManager.insertElement(item: newPerson, index: newPersonIndex, animation: .none)
        itemsCount += 1
        tableElementsCount += 1
        XCTAssert(self.instance.displayManager.items.count == itemsCount, "New element not added")
        XCTAssert(self.instance.displayManager.items.first! as! APPersonsViewController.Model == newPerson, "New element not equal")
        XCTAssert(self.instance.displayManager.tableView!.numberOfRows(inSection: 0) == tableElementsCount, "New table element not added")
        XCTAssert(self.instance.displayManager.tableView!.cellForRow(at: IndexPath(row: newPersonIndex, section: 0))!.textLabel!.text == newPerson.fullName, "New table element not equal")
        
        //reload element 
        newPerson.firstName = "New first name"
        newPerson.lastName = "New last name"
        self.instance.displayManager.reloadElement(index: newPersonIndex, animation: .none)
        XCTAssert(self.instance.displayManager.tableView!.cellForRow(at: IndexPath(row: newPersonIndex, section: 0))!.textLabel!.text == newPerson.fullName, "New teable element not updated")
        
        //move element
        let newPersonMoveIndex = itemsCount - 1
        self.instance.displayManager.moveElement(fromIndex: newPersonIndex, toIndex: newPersonMoveIndex, animation: .none)
        newPersonIndex = newPersonMoveIndex
        XCTAssert(self.instance.displayManager.items[newPersonIndex] as! APPersonsViewController.Model == newPerson, "New element not moved")
        XCTAssert(self.instance.displayManager.tableView!.cellForRow(at: IndexPath(row: newPersonIndex, section: 0))!.textLabel!.text == newPerson.fullName, "New table element not moved")
        
        //delete element
        self.instance.displayManager.deleteElement(index: newPersonIndex, animation: .none)
        XCTAssert((self.instance.displayManager.items as! [APPersonsViewController.Model]).contains(newPerson) == false, "New element not deleted")
    }
}
