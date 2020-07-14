//
//  File.swift
//  
//
//  Created by Oleksandr Kradenkov on 14.07.2020.
//

import XCTest
import GravyKit

class CoupledTests: XCTestCase {

    @Coupled(with: "B", coupledBy: { $0.setString($0 as String + $1) })
    var mutableStringValue = NSMutableString(string: "A")

    func testWrappedPropertyUpdate() {
        XCTAssertEqual(mutableStringValue, "AB")

        mutableStringValue = NSMutableString(string: "C")
        XCTAssertEqual(mutableStringValue, "CB")

        $mutableStringValue = "D"
        XCTAssertEqual(mutableStringValue, "CBD")

        mutableStringValue = "E"
        XCTAssertEqual(mutableStringValue, "ED")

    }
}
