//
//  StepByStepTests.swift
//  StepByStepTests
//
//  Created by Eduardo Jordan on 21/4/21.
//

import XCTest
@testable import StepByStep

class StepByStepTests: XCTestCase {

//    override func setUpWithError() throws {
//        // Put setup code here. This method is called before the invocation of each test method in the class.
//    }
//
//    override func tearDownWithError() throws {
//        // Put teardown code here. This method is called after the invocation of each test method in the class.
//    }
//
//    func testExample() throws {
//        // This is an example of a functional test case.
//        // Use XCTAssert and related functions to verify your tests produce the correct results.
//    }
//
//    func testPerformanceExample() throws {
//        // This is an example of a performance test case.
//        self.measure {
//            // Put the code you want to measure the time of here.
//        }
//    }
    
    func testParseJsonFile() throws {
        guard let pathString = Bundle.main.path(forResource: "Goals", ofType: "json")else {
            fatalError("json not found")
        }
        guard let json = try? String(contentsOfFile: pathString, encoding: .utf8) else {
            fatalError("Unable to convert jsont to String")
        }
        let jsonData = json.data(using: .utf8)!
        let item = try JSONDecoder().decode(Goals.self, from: jsonData)
        XCTAssertEqual("Easy walk steps", item.items[0].title)
       
   }

}
