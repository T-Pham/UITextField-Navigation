//
//  UITextField+Navigation.swift
//  Pods
//
//  Created by Thanh Pham on 6/19/16.
//
//

var NextTextFieldKey: Int8 = 0
var PreviousTextFieldKey: Int8 = 0

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

public extension UITextField {

    /// The next text field. Not retained. Setting this will also set the `previousTextField` on the other text field.
    @IBOutlet weak var nextTextField: UITextField? {
        get {
            return (objc_getAssociatedObject(self, &NextTextFieldKey) as? WeakObjectContainer)?.object as? UITextField
        }

        set {
            nextTextField?.previousTextField = nil
            objc_setAssociatedObject(self, &NextTextFieldKey, WeakObjectContainer(object: newValue), objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            applyInputAccessoryView()
            newValue?.previousTextField = self
        }
    }

    /// The previous text field. Not retained. This is set automatically on the other text field when you set the `nextTextField`.
    weak internal(set) var previousTextField: UITextField? {
        get {
            return (objc_getAssociatedObject(self, &PreviousTextFieldKey) as? WeakObjectContainer)?.object as? UITextField
        }

        set {
            objc_setAssociatedObject(self, &PreviousTextFieldKey, WeakObjectContainer(object: newValue), objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            applyInputAccessoryView()
        }
    }

    /// Apply the `inputAccessoryView`. Useful when you want the Done button but the text field does not have any next or previous text fields.
    func applyInputAccessoryView() {
        let previousButton = UIBarButtonItem(title: "❬", style: .Plain, target: self, action: #selector(previousButtonDidTap))
        previousButton.enabled = previousTextField != nil

        let nextButton = UIBarButtonItem(title: "❭", style: .Plain, target: self, action: #selector(nextButtonDidTap))
        nextButton.enabled = nextTextField != nil

        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .FlexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(barButtonSystemItem: .Done, target: self, action: #selector(doneButtonDidTap))
        let toolBar = UIToolbar()
        toolBar.items = [previousButton, nextButton, flexibleSpace, doneButton]
        toolBar.sizeToFit()
        inputAccessoryView = toolBar
    }

    internal func previousButtonDidTap() {
        if let navigationDelegate = delegate as? UITextFieldNavigationDelegate, method = navigationDelegate.textFieldNavigationDidTapPreviousButton {
            method(self)
        } else {
            previousTextField?.becomeFirstResponder()
        }
    }

    internal func nextButtonDidTap() {
        if let navigationDelegate = delegate as? UITextFieldNavigationDelegate, method = navigationDelegate.textFieldNavigationDidTapNextButton {
            method(self)
        } else {
            nextTextField?.becomeFirstResponder()
        }
    }

    internal func doneButtonDidTap() {
        if let navigationDelegate = delegate as? UITextFieldNavigationDelegate, method = navigationDelegate.textFieldNavigationDidTapDoneButton {
            method(self)
        } else {
            resignFirstResponder()
        }
    }
}

class WeakObjectContainer {
    weak var object: AnyObject?

    init(object anObject: AnyObject?) {
        object = anObject
    }
}
