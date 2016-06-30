//
//  UITextFieldNavigationToolbarTests.swift
//  UITextField_Navigation
//
//  Created by Thanh Pham on 6/30/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import Quick
import Nimble
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
                expect(self.navigationToolbar.previousButton).to(beAKindOf(UITextFieldNavigationToolbarButtonItem))
            }

            it("has the nextButton") {
                expect(self.navigationToolbar.nextButton).to(beAKindOf(UITextFieldNavigationToolbarButtonItem))
            }

            it("has the doneButton") {
                expect(self.navigationToolbar.doneButton).to(beAKindOf(UITextFieldNavigationToolbarButtonItem))
            }

            it("disables init with coder") {
                expect(UITextFieldNavigationToolbar(coder: NSCoder())).to(beNil())
            }
        }
    }
}
