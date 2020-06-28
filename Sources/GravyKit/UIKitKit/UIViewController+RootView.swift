//
//  UIViewController+RootView.swift
//  GravyKit
//
//  Created by Alexander Kradenkov on 8/25/17.
//
//

#if !os(macOS)
import UIKit
#else
import AppKit
#endif

public protocol RootViewContaining {
	associatedtype RootViewType
    
	var rootView: RootViewType? { get }
}

#if !os(macOS)
public typealias SystemVCType = UIViewController
public typealias SystemViewType = UIView
#else
public typealias SystemVCType = NSViewController
public typealias SystemViewType = NSView
#endif

extension RootViewContaining where Self: SystemVCType {
	public var rootView: RootViewType? {
		return self.loadedView as? RootViewType
	}

    /// Returns the view controller's view if loaded, nil if not.
	private var loadedView: SystemViewType? {
        if #available(iOS 9.0, *) {
			return self.viewIfLoaded
		} else {
			return self.isViewLoaded ? view : nil
		}
	}
}

#if os(macOS)
public extension SystemVCType {

    var viewIfLoaded: SystemViewType? {
        return self.isViewLoaded ? view : nil
    }

    func loadViewIfNeeded() {
        if !self.isViewLoaded {
            self.loadView()
        }
    }
}
#endif
