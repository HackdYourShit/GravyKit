//
//  RootViewGettableTests.swift
//  GravyKit
//
//  Created by Oleksandr Kradenkov on 8/25/17.
//
//

import XCTest
import GravyKit

//swiftlint:disable implicitly_unwrapped_optional

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

        if #available(iOS 9.0, *) {
            controller.loadViewIfNeeded()
        } else {
            if !controller.isViewLoaded {
                controller.loadView()
            }
        }

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

class CustomView: SystemViewType { }

class RootViewGettableController: SystemVCType, RootViewContaining {
	typealias RootViewType = CustomView

	override func loadView() {
		self.view = CustomView()
	}
}
