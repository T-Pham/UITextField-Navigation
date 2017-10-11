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
    @IBOutlet var textView: UITextView!
    @IBOutlet var textFieldIB3: UITextField!
    var textFieldCode1: UITextField!
    var textFieldCode2: UITextField!
    var textFieldCode3: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        textFieldCode1 = createRightTextField("UITextField Code 1", leftField: textFieldIB1)
        textFieldCode2 = createRightTextField("UITextField Code 2", leftField: textView)
        textFieldCode3 = createRightTextField("UITextField Code 3", leftField: textFieldIB3)

        textFieldIB3.nextNavigationField = textFieldCode1
        textFieldCode1.nextNavigationField = textFieldCode2
        textFieldCode2.nextNavigationField = textFieldCode3

        textFieldCode2.delegate = self
        textFieldCode2.navigationFieldToolbar?.barStyle = .default
        textFieldCode2.navigationFieldToolbar?.backgroundColor = .red
        textFieldCode2.navigationFieldToolbar?.previousButton.title = "Previous"
        textFieldCode2.navigationFieldToolbar?.nextButton.title = "Next"
        textFieldCode2.navigationFieldToolbar?.doneButton.title = "Dismiss"

        let customButton = UIBarButtonItem(title: "Custom", style: .plain, target: nil, action: nil)
        customButton.tintColor = .white
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        textFieldCode2.navigationFieldToolbar?.items = [textFieldCode2.navigationFieldToolbar!.previousButton, textFieldCode2.navigationFieldToolbar!.nextButton, customButton, flexibleSpace, textFieldCode2.navigationFieldToolbar!.doneButton]
    }

    func createRightTextField(_ placeholder: String, leftField: UIView) -> UITextField {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.font = UIFont.systemFont(ofSize: 14)
        textField.placeholder = placeholder
        textField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(textField)
        view.addConstraints([NSLayoutConstraint(item: textField, attribute: .width, relatedBy: .equal, toItem: leftField, attribute: .width, multiplier: 1, constant: 0), NSLayoutConstraint(item: textField, attribute: .centerY, relatedBy: .equal, toItem: leftField, attribute: .centerY, multiplier: 1, constant: 0), NSLayoutConstraint(item: textField, attribute: .left, relatedBy: .equal, toItem: leftField, attribute: .right, multiplier: 1, constant: 15)])
        return textField
    }
}

extension ViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        print("textFieldDidBeginEditing: \(textField.placeholder ?? "nil")")
    }
}

extension ViewController: NavigationFieldDelegate {

    func navigationFieldDidTapPreviousButton(_ navigationField: NavigationField) {
        print("navigationFieldDidTapPreviousButton: \(navigationField)")
        navigationField.previousNavigationField?.becomeFirstResponder()
    }

    func navigationFieldDidTapNextButton(_ navigationField: NavigationField) {
        print("navigationFieldDidTapNextButton: \(navigationField)")
        navigationField.nextNavigationField?.becomeFirstResponder()
    }

    func navigationFieldDidTapDoneButton(_ navigationField: NavigationField) {
        print("navigationFieldDidTapDoneButton: \(navigationField)")
        navigationField.resignFirstResponder()
    }
}
