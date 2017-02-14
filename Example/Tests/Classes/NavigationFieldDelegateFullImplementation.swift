//
//  NavigationFieldDelegateFullImplementation.swift
//  UITextField-Navigation
//
//  Created by Thanh Pham on 6/30/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import UIKit
import UITextField_Navigation

class NavigationFieldDelegateFullImplementation: NSObject, UITextFieldDelegate, NavigationFieldDelegate {
    var previousButtonTapped = false
    var nextButtonTapped = false
    var doneButtonTapped = false

    @objc func navigationFieldDidTapPreviousButton(_ navigationField: NavigationField) {
        previousButtonTapped = true
    }

    @objc func navigationFieldDidTapNextButton(_ navigationField: NavigationField) {
        nextButtonTapped = true
    }

    @objc func navigationFieldDidTapDoneButton(_ navigationField: NavigationField) {
        doneButtonTapped = true
    }
}
