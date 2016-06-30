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

            it("creates the inputAccessoryView") {
                self.textField.applyInputAccessoryView()
                expect(self.textField.textFieldNavigationToolbar).notTo(beNil())
            }

            it("does not re-create the inputAccessoryView") {
                self.textField.applyInputAccessoryView()
                let inputAccessoryView = self.textField.inputAccessoryView
                self.textField.applyInputAccessoryView()
                expect(inputAccessoryView) == self.textField.inputAccessoryView
            }
        }

        describe("delegate") {

            context("implements all methods") {

                class UITextFieldNavigationDelegateImplementation: NSObject, UITextFieldNavigationDelegate {
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

                var previousTextField: UITextField!
                var nextTextField: UITextField!
                var delegate: UITextFieldNavigationDelegateImplementation!

                beforeEach {
                    previousTextField = UITextField()
                    nextTextField = UITextField()
                    previousTextField.nextTextField = self.textField
                    self.textField.nextTextField = nextTextField;
                    delegate = UITextFieldNavigationDelegateImplementation()
                    self.textField.delegate = delegate
                }

                it("calls the delegate method for the previous button") {
                    let previousButton = self.textField.textFieldNavigationToolbar!.previousButton
                    previousButton.target!.performSelector(previousButton.action)
                    expect(delegate.previousButtonTapped).to(beTrue())
                }

                it("calls the delegate method for the next button") {
                    let nextButton = self.textField.textFieldNavigationToolbar!.nextButton
                    nextButton.target!.performSelector(nextButton.action)
                    expect(delegate.nextButtonTapped).to(beTrue())
                }

                it("calls the delegate method for the done button") {
                    let doneButton = self.textField.textFieldNavigationToolbar!.doneButton
                    doneButton.target!.performSelector(doneButton.action)
                    expect(delegate.doneButtonTapped).to(beTrue())
                }
            }

            context("implements no methods") {

                class UITextFieldNavigationDelegateImplementation: NSObject, UITextFieldNavigationDelegate {}

                class MyTextField: UITextField {
                    var resignFirstResponderPerformed = false
                    var becomeFirstResponderPerformed = false

                    override func resignFirstResponder() -> Bool {
                        resignFirstResponderPerformed = true
                        return super.resignFirstResponder()
                    }

                    private override func becomeFirstResponder() -> Bool {
                        becomeFirstResponderPerformed = true
                        return super.becomeFirstResponder()
                    }
                }

                var textField: MyTextField!
                var previousTextField: MyTextField!
                var nextTextField: MyTextField!
                var delegate: UITextFieldNavigationDelegateImplementation!

                beforeEach {
                    textField = MyTextField()
                    previousTextField = MyTextField()
                    nextTextField = MyTextField()
                    previousTextField.nextTextField = textField
                    textField.nextTextField = nextTextField;
                    delegate = UITextFieldNavigationDelegateImplementation()
                    textField.delegate = delegate
                }

                it("performs the default behavior when tapping the previous button") {
                    let previousButton = textField.textFieldNavigationToolbar!.previousButton
                    previousButton.target!.performSelector(previousButton.action)
                    expect(previousTextField.becomeFirstResponderPerformed).to(beTrue())
                }

                it("performs the default behavior when tapping the next button") {
                    let nextButton = textField.textFieldNavigationToolbar!.nextButton
                    nextButton.target!.performSelector(nextButton.action)
                    expect(nextTextField.becomeFirstResponderPerformed).to(beTrue())
                }

                it("performs the default behavior when tapping the done button") {
                    let doneButton = textField.textFieldNavigationToolbar!.doneButton
                    doneButton.target!.performSelector(doneButton.action)
                    expect(textField.resignFirstResponderPerformed).to(beTrue())
                }
            }
        }
    }
}
