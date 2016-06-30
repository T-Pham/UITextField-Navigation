//
//  MyTextField.swift
//  UITextField-Navigation
//
//  Created by Thanh Pham on 6/30/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import UIKit

class MyTextField: UITextField {
    var resignFirstResponderPerformed = false
    var becomeFirstResponderPerformed = false

    override func resignFirstResponder() -> Bool {
        resignFirstResponderPerformed = true
        return super.resignFirstResponder()
    }

    override func becomeFirstResponder() -> Bool {
        becomeFirstResponderPerformed = true
        return super.becomeFirstResponder()
    }
}
