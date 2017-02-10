//
//  NavigationField.swift
//  UITextField-Navigation
//
//  Created by Thanh Pham on 2/10/17.
//  Copyright © 2017 Thanh Pham. All rights reserved.
//

import UIKit

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

@objc public protocol NavigationField {

    weak var nextNavigationField: NavigationField? { get set }
    weak var previousNavigationField: NavigationField? { get }
    var navigationFieldToolbar: NavigationFieldToolbar? { get }
    var inputAccessoryView: UIView? { get set }

    @discardableResult func becomeFirstResponder() -> Bool
    @discardableResult func resignFirstResponder() -> Bool
    func applyInputAccessoryView()
}
