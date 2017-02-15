//
//  NavigationField.swift
//  UITextField-Navigation
//
//  Created by Thanh Pham on 2/10/17.
//  Copyright © 2017 Thanh Pham. All rights reserved.
//

import UIKit

/// Protocol for delegate of `NavigationField`.
@objc public protocol NavigationFieldDelegate {

    /**
     Tells the `delegate` that the previous button was tapped. The `delegate` has to make the `previousNavigationField` `becomeFirstResponder` if needed.

     - Parameter navigationField: the navigation field whose `inputAccessoryView`'s button was tapped.
     */
    @objc optional func navigationFieldDidTapPreviousButton(_ navigationField: NavigationField)

    /**
     Tells the `delegate` that the next button was tapped. The `delegate` has to make the `nextNavigationField` `becomeFirstResponder` if needed.

     - Parameter navigationField: the navigation field whose `inputAccessoryView`'s button was tapped.
     */
    @objc optional func navigationFieldDidTapNextButton(_ navigationField: NavigationField)

    /**
     Tells the `delegate` that the done button was tapped. The `delegate` has to make the navigation field `resignFirstResponder` if needed.

     - Parameter navigationField: the navigation field whose `inputAccessoryView`'s button was tapped.
     */
    @objc optional func navigationFieldDidTapDoneButton(_ navigationField: NavigationField)
}


/// Protocol for navigation field.
@objc public protocol NavigationField {

    /// The next navigation field.
    weak var nextNavigationField: NavigationField? { get set }

    /// The previous navigation field.
    weak var previousNavigationField: NavigationField? { get }

    /// The toolbar on the keyboard for the receiver.
    var navigationFieldToolbar: NavigationFieldToolbar? { get }

    /// The input accessory view.
    var inputAccessoryView: UIView? { get set }

    /// Make the receiver become first responder.
    @discardableResult func becomeFirstResponder() -> Bool

    /// Make the receiver resign first responder.
    @discardableResult func resignFirstResponder() -> Bool

    /// Force applying the `navigationFieldToolbar` to the keyboard for the receiver.
    func applyInputAccessoryView()
}
