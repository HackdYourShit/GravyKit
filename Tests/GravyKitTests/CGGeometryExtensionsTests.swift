//
//  CGGeometryExtensionsTests.swift
//  CommonTests
//
//  Created by Oleksandr Kradenkov on 9/17/19.
//  Copyright © 2019 Kradenkov PE. All rights reserved.
//

import XCTest
import GravyKit

class CGGeometryExtensionsTests: XCTestCase {

    func testEdgeSizes() {
        let size = CGSize(width: 10, height: 20)
        XCTAssertEqual(size.minEdgeSize, 10)
        XCTAssertEqual(size.maxEdgeSize, 20)
        XCTAssertEqual(CGSize(width: 0, height: 0).minEdgeSize, 0)
        XCTAssertEqual(CGSize(width: 0, height: 0).maxEdgeSize, 0)
        XCTAssertEqual(CGSize(width: -10, height: -20).minEdgeSize, -20)
        XCTAssertEqual(CGSize(width: -10, height: -20).maxEdgeSize, -10)
    }
}
