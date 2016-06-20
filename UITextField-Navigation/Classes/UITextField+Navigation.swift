//
//  UITextField+Navigation.swift
//  Pods
//
//  Created by Thanh Pham on 6/19/16.
//
//

var NextTextFieldKey: Int8 = 0
var PreviousTextFieldKey: Int8 = 0

public extension UITextField {

    @IBOutlet weak public var nextTextField: UITextField? {
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

    weak public internal(set) var previousTextField: UITextField? {
        get {
            return (objc_getAssociatedObject(self, &PreviousTextFieldKey) as? WeakObjectContainer)?.object as? UITextField
        }

        set {
            objc_setAssociatedObject(self, &PreviousTextFieldKey, WeakObjectContainer(object: newValue), objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            applyInputAccessoryView()
        }
    }

    func applyInputAccessoryView() {
        let previousButton = UIBarButtonItem(title: "❬", style: .Plain, target: previousTextField, action: #selector(becomeFirstResponder))
        previousButton.enabled = previousTextField != nil

        let nextButton = UIBarButtonItem(title: "❭", style: .Plain, target: nextTextField, action: #selector(becomeFirstResponder))
        nextButton.enabled = nextTextField != nil

        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .FlexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(barButtonSystemItem: .Done, target: self, action: #selector(resignFirstResponder))
        let toolBar = UIToolbar()
        toolBar.items = [previousButton, nextButton, flexibleSpace, doneButton]
        toolBar.sizeToFit()
        inputAccessoryView = toolBar
    }
}

class WeakObjectContainer {
    weak var object: AnyObject?

    init(object anObject: AnyObject?) {
        object = anObject
    }
}
