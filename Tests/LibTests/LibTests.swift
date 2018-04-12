//
//  LibTests.swift
//  LibTests
//
//  Created by Fatih Nayebi on 2018-04-11.
//

import XCTest
import Lib

class LibTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let filePath = "./config/ApplicationConfiguration.json"

        let app = Application(name: "Perfect", path: filePath)
        guard let db = app.database() else {
            fatalError("Not able to connect to DB")
        }
        
        let database = DatabaseManager(db: db)
        do {
            try database.read(Person.self, where: nil)
        } catch {
            print("error")
        }
        
        //try database.create(Person.self, pk: \Person.id)
        
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
