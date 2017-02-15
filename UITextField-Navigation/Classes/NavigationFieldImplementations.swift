//
//  NavigationFieldImplementations.swift
//  UITextField-Navigation
//
//  Created by Thanh Pham on 2/10/17.
//  Copyright © 2017 Thanh Pham. All rights reserved.
//

import UIKit

/// UITextView extension for NavigationField protocol.
extension UITextView: NavigationField {

    /// The next navigation field. Setting this will also set the `previousNavigationField` on the assigned navigation field.
    @IBOutlet public weak var nextNavigationField: NavigationField? {
        get {
            return internal_nextNavigationField
        }

        set {
            internal_nextNavigationField = newValue
        }
    }

    /// The previous navigation field. This is set automatically on the navigation field which you assign the receiver as `nextNavigationField`.
    public weak var previousNavigationField: NavigationField? {
        return internal_previousNavigationField
    }

    /// Returns the `inputAccessoryView` if it is a `NavigationFieldToolbar`. Otherwise, returns `nil`.
    public var navigationFieldToolbar: NavigationFieldToolbar? {
        return inputAccessoryView as? NavigationFieldToolbar
    }

    /// Apply the `inputAccessoryView`. Useful when you want the Done button but the receiver does not have any next or previous navigation fields.
    public func applyInputAccessoryView() {
        internal_applyInputAccessoryView()
    }
}

/// UITextField extension for NavigationField protocol.
extension UITextField: NavigationField {

    /// The next navigation field. Setting this will also set the `previousNavigationField` on the assigned navigation field.
    @IBOutlet public weak var nextNavigationField: NavigationField? {
        get {
            return internal_nextNavigationField
        }

        set {
            internal_nextNavigationField = newValue
        }
    }

    /// The previous navigation field. This is set automatically on the navigation field which you assign the receiver as `nextNavigationField`.
    public weak var previousNavigationField: NavigationField? {
        return internal_previousNavigationField
    }

    /// Returns the `inputAccessoryView` if it is a `NavigationFieldToolbar`. Otherwise, returns `nil`.
    public var navigationFieldToolbar: NavigationFieldToolbar? {
        return inputAccessoryView as? NavigationFieldToolbar
    }

    /// Apply the `inputAccessoryView`. Useful when you want the Done button but the receiver does not have any next or previous navigation fields.
    public func applyInputAccessoryView() {
        internal_applyInputAccessoryView()
    }
}
