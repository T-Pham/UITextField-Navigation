//
//  UITextFieldNavigationDelegateFullImplementation.swift
//  UITextField-Navigation
//
//  Created by Thanh Pham on 6/30/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import UIKit
import UITextField_Navigation

class UITextFieldNavigationDelegateFullImplementation: NSObject, UITextFieldNavigationDelegate {
    var previousButtonTapped = false
    var nextButtonTapped = false
    var doneButtonTapped = false

    @objc func textFieldNavigationDidTapPreviousButton(_ textField: UITextField) {
        previousButtonTapped = true
    }

    @objc func textFieldNavigationDidTapNextButton(_ textField: UITextField) {
        nextButtonTapped = true
    }

    @objc func textFieldNavigationDidTapDoneButton(_ textField: UITextField) {
        doneButtonTapped = true
    }
}
