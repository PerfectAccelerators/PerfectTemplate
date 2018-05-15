//
//  LibTests.swift
//  LibTests
//
//  Created by Fatih Nayebi on 2018-04-11.
//

import XCTest
import Lib
@testable import ScantORM

class LibTests: XCTestCase {
    
    var filePath: String!
    var app: Application!
    
    override func setUp() {
        super.setUp()
        filePath = "./config/ApplicationConfiguration.json"
        app = Application(name: "Perfect", path: filePath)
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testApplicationInit() {
        XCTAssertNotNil(app)
    }
    
    func testDatabaseConnection() {
        guard let db = app.database() else {
            XCTAssert(false)
            return
        }
        
        let database = DatabaseManager(db: db)
        do {
            let people = try database.read(Person.self, where: nil)
            XCTAssertNotNil(people)
            print("\(String(describing: people.first))")
        } catch {
            print("error")
            XCTAssert(false)
        }
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    static var allTests = [
        ("testDatabaseConnection", testDatabaseConnection),
    ]
}
