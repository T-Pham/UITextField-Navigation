//
//  UITextField+NavigationTests.swift
//  UITextField_Navigation
//
//  Created by Thanh Pham on 6/29/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import Quick
import UITextField_Navigation

class UITextField_NavigationTests: QuickSpec {
    var textField: UITextField!

    override func spec() {

        beforeEach { 
            self.textField = UITextField()
        }

        describe("nextTextField") {

            it("stores the next text field") {
                let nextTextField = UITextField()
                self.textField.nextTextField = nextTextField
                XCTAssertEqual(self.textField.nextTextField, nextTextField)
            }

            it("is nil at the beginning") {
                XCTAssertNil(self.textField.nextTextField)
            }

            it("removes the previous text field of the old next text field") {
                let oldNextTextField = UITextField()
                self.textField.nextTextField = oldNextTextField
                let newNextTextField = UITextField()
                self.textField.nextTextField = newNextTextField;
                XCTAssertNil(oldNextTextField.previousTextField)
            }

            it("does not retain the next text field") {
                autoreleasepool {
                    self.textField.nextTextField = UITextField()
                }
                XCTAssertNil(self.textField.nextTextField)
            }

            it("updates the inputAccessoryView") {
                let nextTextField = UITextField()
                self.textField.nextTextField = nextTextField
                XCTAssertNotNil(self.textField.inputAccessoryView)
            }
        }

        describe("previousTextField") {

            it("stores the previous text field") {
                let previousTextField = UITextField()
                previousTextField.nextTextField = self.textField
                XCTAssertEqual(self.textField.previousTextField, previousTextField)
            }

            it("is nil at the beginning") {
                XCTAssertNil(self.textField.previousTextField)
            }

            it("does not retain the next text field") {
                autoreleasepool {
                    var previousTextField: UITextField? = UITextField()
                    previousTextField!.nextTextField = self.textField
                    previousTextField = nil;
                }
                XCTAssertNil(self.textField.previousTextField)
            }

            it("updates the inputAccessoryView") {
                let previousTextField = UITextField()
                previousTextField.nextTextField = self.textField
                XCTAssertNotNil(self.textField.inputAccessoryView)
            }
        }

        describe("textFieldNavigationToolbar") {

            it("returns the toolbar") {
                let nextTextField = UITextField()
                self.textField.nextTextField = nextTextField
                XCTAssert(self.textField.textFieldNavigationToolbar!.isKind(of: UITextFieldNavigationToolbar.self))
            }

            it("is nil at the beginning") {
                XCTAssertNil(self.textField.textFieldNavigationToolbar)
            }

            it("does not return custom inputAccessoryView") {
                self.textField.inputAccessoryView = UIView()
                XCTAssertNil(self.textField.textFieldNavigationToolbar)
            }
        }

        describe("applyInputAccessoryView") {

            it("creates the inputAccessoryView") {
                self.textField.applyInputAccessoryView()
                XCTAssertNotNil(self.textField.textFieldNavigationToolbar)
            }

            it("does not re-create the inputAccessoryView") {
                self.textField.applyInputAccessoryView()
                let inputAccessoryView = self.textField.inputAccessoryView
                self.textField.applyInputAccessoryView()
                XCTAssertEqual(inputAccessoryView, self.textField.inputAccessoryView)
            }
        }

        describe("delegate") {

            context("implements all methods") {
                var previousTextField: UITextField!
                var nextTextField: UITextField!
                var delegate: UITextFieldNavigationDelegateFullImplementation!

                beforeEach {
                    previousTextField = UITextField()
                    nextTextField = UITextField()
                    previousTextField.nextTextField = self.textField
                    self.textField.nextTextField = nextTextField;
                    delegate = UITextFieldNavigationDelegateFullImplementation()
                    self.textField.delegate = delegate
                }

                it("calls the delegate method for the previous button") {
                    let previousButton = self.textField.textFieldNavigationToolbar!.previousButton
                    _ = previousButton.target!.perform(previousButton.action)
                    XCTAssert(delegate.previousButtonTapped)
                }

                it("calls the delegate method for the next button") {
                    let nextButton = self.textField.textFieldNavigationToolbar!.nextButton
                    _ = nextButton.target!.perform(nextButton.action)
                    XCTAssert(delegate.nextButtonTapped)
                }

                it("calls the delegate method for the done button") {
                    let doneButton = self.textField.textFieldNavigationToolbar!.doneButton
                    _ = doneButton.target!.perform(doneButton.action)
                    XCTAssert(delegate.doneButtonTapped)
                }
            }

            context("implements no methods") {
                var textField: MyTextField!
                var previousTextField: MyTextField!
                var nextTextField: MyTextField!
                var delegate: UITextFieldNavigationDelegateEmptyImplementation!

                beforeEach {
                    textField = MyTextField()
                    previousTextField = MyTextField()
                    nextTextField = MyTextField()
                    previousTextField.nextTextField = textField
                    textField.nextTextField = nextTextField;
                    delegate = UITextFieldNavigationDelegateEmptyImplementation()
                    textField.delegate = delegate
                }

                it("performs the default behavior when tapping the previous button") {
                    let previousButton = textField.textFieldNavigationToolbar!.previousButton
                    _ = previousButton.target!.perform(previousButton.action)
                    XCTAssert(previousTextField.becomeFirstResponderPerformed)
                }

                it("performs the default behavior when tapping the next button") {
                    let nextButton = textField.textFieldNavigationToolbar!.nextButton
                    _ = nextButton.target!.perform(nextButton.action)
                    XCTAssert(nextTextField.becomeFirstResponderPerformed)
                }

                it("performs the default behavior when tapping the done button") {
                    let doneButton = textField.textFieldNavigationToolbar!.doneButton
                    _ = doneButton.target!.perform(doneButton.action)
                    XCTAssert(textField.resignFirstResponderPerformed)
                }
            }
        }
    }
}
