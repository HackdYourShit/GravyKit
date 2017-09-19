//
//  Optional+Unwrap.swift
//  GravyKit
//
//  Created by Alexander Kradenkov on 8/18/17.
//
//

public extension Optional {
	func orFail(with error: Error) throws -> Wrapped {
		switch self {
		case .some(let value):
			return value
		default:
			throw error
		}
	}
}

// According my observations, using `flatMap()` to unwrap Optional values is twise slower.
// So, I just used `copy-paste` approach. Sorry if your eyes heart bacause of this :)

public func unwrap<T>(_ value: T?) -> (T)? {
	if let `value` = value {
		return (value)
	} else {
		return nil
	}
}

public func unwrap<T, U>(_ first: T?, _ second: U?) -> (T, U)? {
	switch (first, second) {
	case (.some(let firstValue), .some(let secondValue)):
		return (firstValue, secondValue)
	default:
		return nil
	}
}

//swiftlint:disable large_tuple
public func unwrap<T, U, V>(_ first: T?, _ second: U?, _ third: V?) -> (T, U, V)? {
	switch (first, second, third) {
	case (.some(let firstValue), .some(let secondValue), .some(let thirdValue)):
		return (firstValue, secondValue, thirdValue)
	default:
		return nil
	}
}

public func unwrap<T, U, V, W>(_ first: T?, _ second: U?, _ third: V?, _ fourth: W?) -> (T, U, V, W)? {
	switch (first, second, third, fourth) {
	case (.some(let firstValue), .some(let secondValue), .some(let thirdValue), .some(let fourth)):
		return (firstValue, secondValue, thirdValue, fourth)
	default:
		return nil
	}
}

//swiftlint:enable large_tuple
