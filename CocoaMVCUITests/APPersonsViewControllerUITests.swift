//
//  APPersonsViewControllerUITests.swift
//  APPersonsViewControllerUITests
//
//  Created by Vladimir Goncharov on 09/07/2017.
//  Copyright © 2017 Vladimir. All rights reserved.
//

import XCTest

class APPersonsViewControllerUITests: XCTestCase {
    
    var application: XCUIApplication!
        
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        
        self.application = XCUIApplication()
        self.application.launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        self.application = nil
        super.tearDown()
    }
    
    //MARK: -
    func testSegue() {
        self.application.tables.element.cells.element(boundBy: 0).tap()
        XCUIApplication().navigationBars["Eba Abe"].buttons["Persons"].tap()
    }
}
