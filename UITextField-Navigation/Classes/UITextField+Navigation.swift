//
//  UITextField+Navigation.swift
//  Pods
//
//  Created by Thanh Pham on 6/19/16.
//
//

import UIKit

var NextTextFieldKey: Int8 = 0
var PreviousTextFieldKey: Int8 = 0

public extension UITextField {

    /// The next text field. Not retained. Setting this will also set the `previousTextField` on the other text field.
    @IBOutlet weak var nextTextField: UITextField? {
        get {
            return retrieveTextField(&NextTextFieldKey)
        }

        set {
            nextTextField?.previousTextField = nil
            storeTextField(newValue, withKey: &NextTextFieldKey)
            applyInputAccessoryView()
            newValue?.previousTextField = self
        }
    }

    /// The previous text field. Not retained. This is set automatically on the other text field when you set the `nextTextField`.
    weak internal(set) var previousTextField: UITextField? {
        get {
            return retrieveTextField(&PreviousTextFieldKey)
        }

        set {
            storeTextField(newValue, withKey: &PreviousTextFieldKey)
            applyInputAccessoryView()
        }
    }

    /// Returns the `inputAccessoryView` if it is a `UITextFieldNavigationToolbar`. Otherwise, returns `nil`.
    var textFieldNavigationToolbar: UITextFieldNavigationToolbar? {
        get {
            return inputAccessoryView as? UITextFieldNavigationToolbar
        }
    }

    /// Apply the `inputAccessoryView`. Useful when you want the Done button but the text field does not have any next or previous text fields.
    func applyInputAccessoryView() {
        if textFieldNavigationToolbar == nil {
            let navigationToolbar = UITextFieldNavigationToolbar()
            navigationToolbar.navigationDelegate = self
            inputAccessoryView = navigationToolbar
        }

        textFieldNavigationToolbar?.previousButton.isEnabled = previousTextField != nil
        textFieldNavigationToolbar?.nextButton.isEnabled = nextTextField != nil
    }

    internal func storeTextField(_ textField: UITextField?, withKey key: UnsafeRawPointer) {
        if let textField = textField {
            objc_setAssociatedObject(self, key, WeakObjectContainer(object: textField), objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        } else {
            objc_setAssociatedObject(self, key, nil, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }

    internal func retrieveTextField(_ key: UnsafeRawPointer) -> UITextField? {
        guard let weakObjectContainer = objc_getAssociatedObject(self, key) else {
            return nil
        }
        guard let textField = (weakObjectContainer as? WeakObjectContainer)?.object as? UITextField else {
            storeTextField(nil, withKey: key)
            return nil
        }
        return textField
    }
}

extension UITextField: UITextFieldNavigationToolbarDelegate {
    func textFieldNavigationToolbarDidTapPreviousButton(_ textFieldNavigationToolbar: UITextFieldNavigationToolbar) {
        if let navigationDelegate = delegate as? UITextFieldNavigationDelegate, let method = navigationDelegate.textFieldNavigationDidTapPreviousButton {
            method(self)
        } else {
            previousTextField?.becomeFirstResponder()
        }
    }

    func textFieldNavigationToolbarDidTapNextButton(_ textFieldNavigationToolbar: UITextFieldNavigationToolbar) {
        if let navigationDelegate = delegate as? UITextFieldNavigationDelegate, let method = navigationDelegate.textFieldNavigationDidTapNextButton {
            method(self)
        } else {
            nextTextField?.becomeFirstResponder()
        }
    }

    func textFieldNavigationToolbarDidTapDoneButton(_ textFieldNavigationToolbar: UITextFieldNavigationToolbar) {
        if let navigationDelegate = delegate as? UITextFieldNavigationDelegate, let method = navigationDelegate.textFieldNavigationDidTapDoneButton {
            method(self)
        } else {
            resignFirstResponder()
        }
    }
}
