//
//  NSLocking+Extensions.swift
//  GravyKit
//
//  Created by Alexander Kradenkov on 1/28/17.
//
//

import Foundation

extension NSLocking {
	public func sync<T>(_ block:() throws -> T) rethrows -> T {
		defer { self.unlock() }
		self.lock()

		return try block()
	}
}
