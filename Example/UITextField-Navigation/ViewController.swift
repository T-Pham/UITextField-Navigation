//
//  ViewController.swift
//  UITextField-Navigation
//
//  Created by Thanh Pham on 06/19/2016.
//  Copyright (c) 2016 Thanh Pham. All rights reserved.
//

import UIKit
import UITextField_Navigation

class ViewController: UIViewController {
    @IBOutlet var textFieldIB1: UITextField!
    @IBOutlet var textFieldIB2: UITextField!
    @IBOutlet var textFieldIB3: UITextField!
    var textFieldCode1: UITextField!
    var textFieldCode2: UITextField!
    var textFieldCode3: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        textFieldCode1 = createRightTextField("UITextField Code 1", leftTextField: textFieldIB1)
        textFieldCode2 = createRightTextField("UITextField Code 2", leftTextField: textFieldIB2)
        textFieldCode3 = createRightTextField("UITextField Code 3", leftTextField: textFieldIB3)

        textFieldIB3.nextTextField = textFieldCode1
        textFieldCode1.nextTextField = textFieldCode2
        textFieldCode2.nextTextField = textFieldCode3

        textFieldCode2.delegate = self
        textFieldCode2.textFieldNavigationToolbar?.barStyle = .Default
        textFieldCode2.textFieldNavigationToolbar?.backgroundColor = UIColor.redColor()
        textFieldCode2.textFieldNavigationToolbar?.previousButton.title = "Previous"
        textFieldCode2.textFieldNavigationToolbar?.nextButton.title = "Next"
        textFieldCode2.textFieldNavigationToolbar?.doneButton.title = "Dismiss"

        let customButton = UIBarButtonItem(title: "Custom", style: .Plain, target: nil, action: nil)
        customButton.tintColor = UIColor.whiteColor()
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .FlexibleSpace, target: nil, action: nil)
        textFieldCode2.textFieldNavigationToolbar?.items = [textFieldCode2.textFieldNavigationToolbar!.previousButton, textFieldCode2.textFieldNavigationToolbar!.nextButton, customButton, flexibleSpace, textFieldCode2.textFieldNavigationToolbar!.doneButton]
    }

    func createRightTextField(placeholder: String, leftTextField: UITextField) -> UITextField {
        let textField = UITextField()
        textField.borderStyle = .RoundedRect
        textField.font = leftTextField.font
        textField.placeholder = placeholder
        textField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(textField)
        view.addConstraints([NSLayoutConstraint(item: textField, attribute: .Width, relatedBy: .Equal, toItem: leftTextField, attribute: .Width, multiplier: 1, constant: 0), NSLayoutConstraint(item: textField, attribute: .CenterY, relatedBy: .Equal, toItem: leftTextField, attribute: .CenterY, multiplier: 1, constant: 0), NSLayoutConstraint(item: textField, attribute: .Left, relatedBy: .Equal, toItem: leftTextField, attribute: .Right, multiplier: 1, constant: 15)])
        return textField
    }
}

extension ViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(textField: UITextField) {
        print("textFieldDidBeginEditing: \(textField.placeholder)")
    }
}

extension ViewController: UITextFieldNavigationDelegate {

    func textFieldNavigationDidTapPreviousButton(textField: UITextField) {
        print("textFieldNavigationDidTapPreviousButton: \(textField.placeholder)")
        textField.previousTextField?.becomeFirstResponder()
    }

    func textFieldNavigationDidTapNextButton(textField: UITextField) {
        print("textFieldNavigationDidTapNextButton: \(textField.placeholder)")
        textField.nextTextField?.becomeFirstResponder()
    }

    func textFieldNavigationDidTapDoneButton(textField: UITextField) {
        print("textFieldNavigationDidTapDoneButton: \(textField.placeholder)")
        textField.resignFirstResponder()
    }
}
