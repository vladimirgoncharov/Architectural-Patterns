//
//  APPersonTests.swift
//  Architectural Patterns
//
//  Created by Vladimir Goncharov on 10/07/2017.
//  Copyright © 2017 Vladimir. All rights reserved.
//

import XCTest
@testable import CocoaMVC

class APPersonTests: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    //MARK: - Tests
    func testFullName() {
        let instance = APPerson(firstName: "FirstName", lastName: "LastName")
        XCTAssert(instance.fullName == "LastName FirstName")
        
        instance.firstName = ""
        instance.lastName = "LastName"
        XCTAssert(instance.fullName == "LastName")
        
        instance.firstName = "FirstName"
        instance.lastName = ""
        XCTAssert(instance.fullName == "FirstName")
        
        instance.firstName = ""
        instance.lastName = ""
        XCTAssert(instance.fullName == "")
    }
}
