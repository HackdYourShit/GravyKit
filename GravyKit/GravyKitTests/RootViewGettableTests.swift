//
//  RootViewGettableTests.swift
//  GravyKit
//
//  Created by Oleksandr Kradenkov on 8/25/17.
//
//

import XCTest
import GravyKit

class RootViewGettableTests: XCTestCase {
	var controller: RootViewGettableController!

	override func setUp() {
		super.setUp()

		self.controller = RootViewGettableController()
	}

	func testRootViewMustBeNilBeforeViewIsAccessed() {
		guard let controller = self.controller else {
			XCTFail("controller must not be nil")

			return
		}

		XCTAssertFalse(controller.isViewLoaded)
		XCTAssertNil(controller.rootView)
	}

	func testRootViewMustNotBeNilAfterViewIsAccessed() {
		guard let controller = self.controller else {
			XCTFail("controller must not be nil")

			return
		}

		XCTAssertFalse(controller.isViewLoaded)

		controller.loadViewIfNeeded()

		XCTAssertTrue(controller.isViewLoaded)
		XCTAssertNotNil(controller.view)

		XCTAssertTrue(controller.isViewLoaded)
		XCTAssertNotNil(controller.rootView)
		XCTAssertNotNil(controller.view)

		_ = controller.rootView.map {
			XCTAssertTrue($0.isKind(of: CustomView.self), "rootView must be inherited from CustomView")
		}

		XCTAssertEqual(controller.view, self.controller.rootView)
	}
}

class CustomView: UIView { }

class RootViewGettableController: UIViewController, RootViewContaining {
	typealias RootViewType = CustomView

	override func loadView() {
		self.view = CustomView()
	}
}
