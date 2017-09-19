//
//  OptionalUnwrapTests.swift
//  GravyKit
//
//  Created by Alexander Kradenkov on 8/18/17.
//
//

import XCTest
import GravyKit

class OptionalUnwrapTests: XCTestCase {

	func testUnwrapTwoOptionals() {
		[
			unwrapped(1),
			unwrapped(1, 2),
			unwrapped(1, 2, 3),
			unwrapped(1, 2, 3, 4)
			]
			.forEach { XCTAssertNotNil($0) }

		[
			unwrapped(nil),

			unwrapped(nil, 2),
			unwrapped(1, nil),
			unwrapped(nil, nil),

			unwrapped(nil, 2, 3),
			unwrapped(1, nil, 3),
			unwrapped(1, 2, nil),
			unwrapped(nil, nil, nil),

			unwrapped(nil, 2, 3, 4),
			unwrapped(1, nil, 3, 4),
			unwrapped(1, 2, nil, 4),
			unwrapped(1, 2, 3, nil),
			unwrapped(nil, nil, nil, nil)

			]
			.forEach { XCTAssertNil($0) }
	}

	private func unwrapped(_ values:Any?...) -> Any? {
		let count = values.count
		switch values.count {
		case 1:
			return unwrap(values[0])
		case 2:
			return unwrap(values[0], values[1])
		case 3:
			return unwrap(values[0], values[1], values[2])
		case 4:
			return unwrap(values[0], values[1], values[2], values[3])
		default:
			XCTFail("unwrap() function is not implemented for \(count) agruments")
			return nil
		}
	}
}
