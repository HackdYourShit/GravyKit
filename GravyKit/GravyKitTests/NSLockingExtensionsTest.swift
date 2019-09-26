//
//  NSLockingExtensionsTest.swift
//  GravyKit
//
//  Created by Alexander Kradenkov on 1/28/17.
//
//

import XCTest
@testable import GravyKit

//swiftlint:disable implicitly_unwrapped_optional

class NSLockingExtensionsTest: XCTestCase {
	var lock: NSLocking!

	override func setUp() {
        super.setUp()
		lock = MockLock()
	}

	func testSyncBlockCanReturnValue() {
		let anObject = NSObject()

		XCTAssertEqual(anObject, lock.sync { return anObject })
	}

	func testSyncBlockCanThrow() throws {
		XCTAssertThrowsError(try lock.sync { throw MockError() })
	}

	func testIsLockedOnlyWhileRunningBlock() {
		_ = (lock as? MockLock).map { aLock in
			XCTAssertFalse(aLock.isLocked)
			aLock.sync { XCTAssertTrue(aLock.isLocked) }
			XCTAssertFalse(aLock.isLocked)
		}
	}
}

class MockError: Error {}

class MockLock: NSLocking {
	var isLocked = false

	// MARK: - NSLocking

	func lock() {
		isLocked = true
	}

	func unlock() {
		isLocked = false
	}
}
