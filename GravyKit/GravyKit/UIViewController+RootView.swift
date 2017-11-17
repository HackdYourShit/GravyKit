//
//  UIViewController+RootView.swift
//  GravyKit
//
//  Created by Alexander Kradenkov on 8/25/17.
//
//

import UIKit

public protocol RootViewGettable {
	associatedtype ViewType
	var rootView: ViewType? { get }
}

extension RootViewGettable where Self: UIViewController {
	public var rootView: ViewType? {
		return self.loadedView as? ViewType
	}
	
	/// Returns the view controller's view if loaded, nil if not.
	private var loadedView: UIView? {
		if #available(iOS 9.0, *) {
			return self.viewIfLoaded
		} else {
			return self.isViewLoaded ? view : nil
		}
	}
}

extension UIView {
	/// Breadth-first search for subview that matches specified type
	public func findSubview<T>(ofType type: T.Type) -> T? where T: UIView {
		var queue = subviews
		while !queue.isEmpty {
			let subview = queue.removeFirst()
			if let subview = subview as? T {
				return subview
			}
			queue.append(contentsOf: subview.subviews)
		}

		return nil
	}
}
