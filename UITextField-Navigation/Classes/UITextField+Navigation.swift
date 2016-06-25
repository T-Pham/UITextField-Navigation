//
//  UITextField+Navigation.swift
//  Pods
//
//  Created by Thanh Pham on 6/19/16.
//
//

var NavigationDelegateKey: Int8 = 0
var NextTextFieldKey: Int8 = 0
var PreviousTextFieldKey: Int8 = 0

@objc public protocol UITextFieldNavigationDelegate {
    optional func textFieldNavigationDidTapPreviousButton(textField: UITextField)
    optional func textFieldNavigationDidTapNextButton(textField: UITextField)
    optional func textFieldNavigationDidTapDoneButton(textField: UITextField)
}

public extension UITextField {

    @IBOutlet weak var navigationDelegate: UITextFieldNavigationDelegate? {
        get {
            return (objc_getAssociatedObject(self, &NavigationDelegateKey) as? WeakObjectContainer)?.object as? UITextFieldNavigationDelegate
        }

        set {
            objc_setAssociatedObject(self, &NavigationDelegateKey, WeakObjectContainer(object: newValue), objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            applyInputAccessoryView()
        }
    }

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

    weak internal(set) var previousTextField: UITextField? {
        get {
            return (objc_getAssociatedObject(self, &PreviousTextFieldKey) as? WeakObjectContainer)?.object as? UITextField
        }

        set {
            objc_setAssociatedObject(self, &PreviousTextFieldKey, WeakObjectContainer(object: newValue), objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            applyInputAccessoryView()
        }
    }

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
        if let navigationDelegate = navigationDelegate, method = navigationDelegate.textFieldNavigationDidTapPreviousButton {
            method(self)
        } else {
            previousTextField?.becomeFirstResponder()
        }
    }

    internal func nextButtonDidTap() {
        if let navigationDelegate = navigationDelegate, method = navigationDelegate.textFieldNavigationDidTapNextButton {
            method(self)
        } else {
            nextTextField?.becomeFirstResponder()
        }
    }

    internal func doneButtonDidTap() {
        if let navigationDelegate = navigationDelegate, method = navigationDelegate.textFieldNavigationDidTapDoneButton {
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
