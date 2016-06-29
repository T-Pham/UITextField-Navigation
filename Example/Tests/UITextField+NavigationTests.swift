//
//  UITextField+NavigationTests.swift
//  UITextField_Navigation
//
//  Created by Thanh Pham on 6/29/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import Quick
import Nimble
import UITextField_Navigation

class UITextField_NavigtionTests: QuickSpec {
    var textField: UITextField!

    override func spec() {

        beforeEach { 
            self.textField = UITextField()
        }

        describe("nextTextField") {

            it("stores the next text field") {
                let nextTextField = UITextField()
                self.textField.nextTextField = nextTextField
                expect(self.textField.nextTextField) == nextTextField
            }

            it("is nil at the beginning") {
                expect(self.textField.nextTextField).to(beNil())
            }

            it("removes the previous text field of the old next text field") {
                let oldNextTextField = UITextField()
                self.textField.nextTextField = oldNextTextField
                let newNextTextField = UITextField()
                self.textField.nextTextField = newNextTextField;
                expect(oldNextTextField.previousTextField).to(beNil())
            }

            it("does not retain the next text field") {
                var nextTextField: UITextField? = UITextField()
                self.textField.nextTextField = nextTextField
                nextTextField = nil
                expect(self.textField.nextTextField).toEventually(beNil())
            }

            it("updates the inputAccessoryView") {
                let nextTextField = UITextField()
                self.textField.nextTextField = nextTextField
                expect(self.textField.inputAccessoryView).notTo(beNil())
            }
        }

        describe("previousTextField") {

            it("stores the previous text field") {
                let previousTextField = UITextField()
                previousTextField.nextTextField = self.textField
                expect(self.textField.previousTextField) == previousTextField
            }

            it("is nil at the beginning") {
                expect(self.textField.previousTextField).to(beNil())
            }

            it("does not retain the next text field") {
                var previousTextField: UITextField? = UITextField()
                previousTextField!.nextTextField = self.textField
                previousTextField = nil;
                expect(self.textField.previousTextField).toEventually(beNil())
            }

            it("updates the inputAccessoryView") {
                let previousTextField = UITextField()
                previousTextField.nextTextField = self.textField
                expect(self.textField.inputAccessoryView).notTo(beNil())
            }
        }

        describe("textFieldNavigationToolbar") {

            it("returns the toolbar") {
                let nextTextField = UITextField()
                self.textField.nextTextField = nextTextField
                expect(self.textField.textFieldNavigationToolbar).to(beAKindOf(UITextFieldNavigationToolbar))
            }

            it("is nil at the beginning") {
                expect(self.textField.textFieldNavigationToolbar).to(beNil())
            }

            it("does not return custom inputAccessoryView") {
                self.textField.inputAccessoryView = UIView()
                expect(self.textField.textFieldNavigationToolbar).to(beNil())
            }
        }

        describe("applyInputAccessoryView") {

            it("should create the inputAccessoryView") {
                self.textField.applyInputAccessoryView()
                expect(self.textField.textFieldNavigationToolbar).notTo(beNil())
            }

            it("should not re-create the inputAccessoryView") {
                self.textField.applyInputAccessoryView()
                let inputAccessoryView = self.textField.inputAccessoryView
                self.textField.applyInputAccessoryView()
                expect(inputAccessoryView) == self.textField.inputAccessoryView
            }
        }
    }
}
