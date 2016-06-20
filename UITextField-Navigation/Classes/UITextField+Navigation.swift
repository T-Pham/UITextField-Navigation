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
            return objc_getAssociatedObject(self, &NextTextFieldKey) as? UITextField
        }

        set {
            if let oldTextField = nextTextField {
                oldTextField.previousTextField = nil
            }

            objc_setAssociatedObject(self, &NextTextFieldKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            assignInputAccessoryView()

            if let newTextField = newValue {
                newTextField.previousTextField = self
            }
        }
    }

    weak public internal(set) var previousTextField: UITextField? {
        get {
            return objc_getAssociatedObject(self, &PreviousTextFieldKey) as? UITextField
        }

        set {
            objc_setAssociatedObject(self, &PreviousTextFieldKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            assignInputAccessoryView()
        }
    }

    func assignInputAccessoryView() {
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
