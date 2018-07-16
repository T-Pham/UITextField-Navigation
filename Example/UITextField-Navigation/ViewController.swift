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
    @IBOutlet var textViewIB2: UITextView!
    @IBOutlet var textFieldIB3: UITextField!
    var textFieldCode1: UITextField!
    var textViewCode2: UITextView!
    var textFieldCode3: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        setUpBorder(for: textViewIB2)

        textFieldCode1 = createRightTextField("UITextField Code 1", leftField: textFieldIB1)
        textViewCode2 = createRightTextView("UITextView Code 2", leftField: textViewIB2)
        textFieldCode3 = createRightTextField("UITextField Code 3", leftField: textFieldIB3)

        textFieldIB3.nextNavigationField = textFieldCode1
        textFieldCode1.nextNavigationField = textViewCode2
        textViewCode2.nextNavigationField = textFieldCode3

        textFieldCode3.delegate = self
        textFieldCode3.navigationFieldToolbar?.barStyle = .default
        textFieldCode3.navigationFieldToolbar?.backgroundColor = .red
        textFieldCode3.navigationFieldToolbar?.previousButton.title = "Previous"
        textFieldCode3.navigationFieldToolbar?.nextButton.title = "Next"
        textFieldCode3.navigationFieldToolbar?.doneButton.title = "Dismiss"

        let customButton = UIBarButtonItem(title: "Custom", style: .plain, target: nil, action: nil)
        customButton.tintColor = .white
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        textFieldCode3.navigationFieldToolbar?.items = [textFieldCode3.navigationFieldToolbar!.previousButton, textFieldCode3.navigationFieldToolbar!.nextButton, customButton, flexibleSpace, textFieldCode3.navigationFieldToolbar!.doneButton]
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

    func createRightTextView(_ text: String, leftField: UIView) -> UITextView {
        let textView = UITextView()
        setUpBorder(for: textView)
        textView.font = UIFont.systemFont(ofSize: 14)
        textView.text = text
        textView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(textView)
        view.addConstraints([NSLayoutConstraint(item: textView, attribute: .width, relatedBy: .equal, toItem: leftField, attribute: .width, multiplier: 1, constant: 0), NSLayoutConstraint(item: textView, attribute: .height, relatedBy: .equal, toItem: leftField, attribute: .height, multiplier: 1, constant: 0), NSLayoutConstraint(item: textView, attribute: .centerY, relatedBy: .equal, toItem: leftField, attribute: .centerY, multiplier: 1, constant: 0), NSLayoutConstraint(item: textView, attribute: .left, relatedBy: .equal, toItem: leftField, attribute: .right, multiplier: 1, constant: 15)])
        return textView
    }

    func setUpBorder(for textView: UITextView) {
        textView.layer.borderColor = UIColor.lightGray.cgColor
        textView.layer.borderWidth = 1
        textView.layer.cornerRadius = 4
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
