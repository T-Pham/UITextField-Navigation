//
//  UITextFieldNavigationToolbarTests.swift
//  UITextField_Navigation
//
//  Created by Thanh Pham on 6/30/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import Quick
import UITextField_Navigation

class UITextFieldNavigationToolbarTests: QuickSpec {
    var navigationToolbar: UITextFieldNavigationToolbar!

    override func spec() {

        beforeEach() {
            let textField = UITextField()
            textField.applyInputAccessoryView()
            self.navigationToolbar = textField.textFieldNavigationToolbar
        }

        describe("UITextFieldNavigationToolbar") {

            it("has the previousButton") {
                XCTAssert(self.navigationToolbar.previousButton.isKind(of: UITextFieldNavigationToolbarButtonItem.self))
            }

            it("has the nextButton") {
                XCTAssert(self.navigationToolbar.nextButton.isKind(of: UITextFieldNavigationToolbarButtonItem.self))
            }

            it("has the doneButton") {
                XCTAssert(self.navigationToolbar.doneButton.isKind(of: UITextFieldNavigationToolbarButtonItem.self))
            }

            it("disables init with coder") {
                XCTAssertNil(UITextFieldNavigationToolbar(coder: NSCoder()))
            }
        }
    }
}
