//
//  UITextFieldNavigationDelegateFullImplementation.swift
//  UITextField-Navigation
//
//  Created by Thanh Pham on 6/30/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import Foundation
import UITextField_Navigation

class UITextFieldNavigationDelegateFullImplementation: NSObject, UITextFieldNavigationDelegate {
    var previousButtonTapped = false
    var nextButtonTapped = false
    var doneButtonTapped = false

    @objc func textFieldNavigationDidTapPreviousButton(textField: UITextField) {
        previousButtonTapped = true
    }

    @objc func textFieldNavigationDidTapNextButton(textField: UITextField) {
        nextButtonTapped = true
    }

    @objc func textFieldNavigationDidTapDoneButton(textField: UITextField) {
        doneButtonTapped = true
    }
}
