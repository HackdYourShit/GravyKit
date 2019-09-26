//
//  UIViewController+RootView.swift
//  GravyKit
//
//  Created by Alexander Kradenkov on 8/25/17.
//
//

import UIKit

public protocol RootViewContaining {
	associatedtype RootViewType
    
	var rootView: RootViewType? { get }
}

extension RootViewContaining where Self: UIViewController {
	public var rootView: RootViewType? {
		return self.loadedView as? RootViewType
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
