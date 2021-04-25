//
//  StepByStepTests.swift
//  StepByStepTests
//
//  Created by Eduardo Jordan on 21/4/21.
//

import XCTest
@testable import StepByStep

class StepByStepTests: XCTestCase {

  
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
