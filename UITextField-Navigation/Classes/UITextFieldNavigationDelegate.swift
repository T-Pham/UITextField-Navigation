//
//  UITextFieldNavigationDelegate.swift
//  Pods
//
//  Created by Thanh Pham on 6/27/16.
//
//

import UIKit

/// The `UITextFieldNavigationDelegate` protocol defines methods used for capturing taps on the `inputAccessoryView`'s buttons. All of the methods of this protocol are optional. Objects conforming to this protocol also conform to the `UITextFieldDelegate` protocol.
@objc public protocol UITextFieldNavigationDelegate: UITextFieldDelegate {

    /**
     Tells the `delegate` that the previous button was tapped. The `delegate` has to make the `previousTextField` `becomeFirstResponder` if needed.

     - Parameter textField: the text field whose `inputAccessoryView`'s button was tapped.
     */
    optional func textFieldNavigationDidTapPreviousButton(textField: UITextField)

    /**
     Tells the `delegate` that the next button was tapped. The `delegate` has to make the `nextTextField` `becomeFirstResponder` if needed.

     - Parameter textField: the text field whose `inputAccessoryView`'s button was tapped.
     */
    optional func textFieldNavigationDidTapNextButton(textField: UITextField)

    /**
     Tells the `delegate` that the done button was tapped. The `delegate` has to make the text field `resignFirstResponder` if needed.

     - Parameter textField: the text field whose `inputAccessoryView`'s button was tapped.
     */
    optional func textFieldNavigationDidTapDoneButton(textField: UITextField)
}
