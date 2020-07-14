//
//  File.swift
//  
//
//  Created by Oleksandr Kradenkov on 14.07.2020.
//

import XCTest
import GravyKit

class CoupledValueTests: XCTestCase {
    struct Value: Equatable {
        let intValue: Int
    }


    @Coupled(with: 1, coupledBy: { Value(intValue: $0.intValue + $1)})
    var value = Value(intValue: 1)

    func testWrappedValueisValueType() {
        XCTAssertFalse(type(of:value) is AnyClass)
    }

    func testWrappedPropertyUpdate() {
        XCTAssertEqual(value, Value(intValue: 2))

        value = Value(intValue: 2)
        XCTAssertEqual(value,  Value(intValue: 3))

        $value = 5
        XCTAssertEqual(value, Value(intValue: 8))

        value = Value(intValue: 5)
        XCTAssertEqual(value, Value(intValue: 10))

    }
}

class CoupledWrappedObjectWithOnUpdateClosureTests: XCTestCase {

    @Coupled(with: "B", onUpdate: { $0.append($1) })
    var value = "A" as NSMutableString

    func testWrappedValueisObjectType() {
        XCTAssertTrue(type(of:value) is AnyClass)
    }

    func testWrappedPropertyUpdate() {
        XCTAssertEqual(value, "AB")

        value = "C"
        XCTAssertEqual(value, "CB")

        $value = "D"
        XCTAssertEqual(value, "CBD")

        value = "E"
        XCTAssertEqual(value, "ED")

    }
}

class CoupledWrappedObjectWithOnUpdateMethodTests: XCTestCase {

    @Coupled(with: "B", onUpdate: NSMutableString.append)
    var value = "A" as NSMutableString

    func testWrappedValueisObjectType() {
        XCTAssertTrue(type(of:value) is AnyClass)
    }

    func testWrappedPropertyUpdate() {
        XCTAssertEqual(value, "AB")

        value = "C"
        XCTAssertEqual(value, "CB")

        $value = "D"
        XCTAssertEqual(value, "CBD")

        value = "E"
        XCTAssertEqual(value, "ED")
    }
}
