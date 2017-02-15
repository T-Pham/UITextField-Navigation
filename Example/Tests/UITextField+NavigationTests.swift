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

    var navigationField: NavigationField!

    override func spec() {

        beforeEach { 
            self.navigationField = UITextField()
        }

        describe("nextNavigationField") {

            it("stores the next navigation field") {
                let nextNavigationField: NavigationField = UITextView()
                self.navigationField.nextNavigationField = nextNavigationField
                XCTAssertEqual(self.navigationField.nextNavigationField as! UITextView, nextNavigationField as! UITextView)
            }

            it("is nil at the beginning") {
                XCTAssertNil(self.navigationField.nextNavigationField)
            }

            it("removes the previous navigation field of the old next navigation field") {
                let oldNextNavigationField: NavigationField = UITextField()
                self.navigationField.nextNavigationField = oldNextNavigationField
                let newNextNavigationField: NavigationField = UITextView()
                self.navigationField.nextNavigationField = newNextNavigationField;
                XCTAssertNil(oldNextNavigationField.previousNavigationField)
            }

            it("does not retain the next navigation field") {
                autoreleasepool {
                    self.navigationField.nextNavigationField = UITextView()
                }
                XCTAssertNil(self.navigationField.nextNavigationField)
            }

            it("updates the inputAccessoryView") {
                let nextNavigationField: NavigationField = UITextView()
                self.navigationField.nextNavigationField = nextNavigationField
                XCTAssertNotNil(self.navigationField.inputAccessoryView)
            }
        }

        describe("previousNavigationField") {

            it("stores the previous navigation field") {
                let previousNavigationField: NavigationField = UITextView()
                previousNavigationField.nextNavigationField = self.navigationField
                XCTAssertEqual(self.navigationField.previousNavigationField as! UITextView, previousNavigationField as! UITextView)
            }

            it("is nil at the beginning") {
                XCTAssertNil(self.navigationField.previousNavigationField)
            }

            it("does not retain the next navigation field") {
                autoreleasepool {
                    var previousNavigationField: NavigationField? = UITextView()
                    previousNavigationField!.nextNavigationField = self.navigationField
                    previousNavigationField = nil;
                }
                XCTAssertNil(self.navigationField.previousNavigationField)
            }

            it("updates the inputAccessoryView") {
                let previousNavigationField: NavigationField = UITextView()
                previousNavigationField.nextNavigationField = self.navigationField
                XCTAssertNotNil(self.navigationField.inputAccessoryView)
            }
        }

        describe("NavigationFieldToolbar") {

            it("returns the toolbar") {
                let nextNavigationField: NavigationField = UITextView()
                self.navigationField.nextNavigationField = nextNavigationField
                XCTAssert(self.navigationField.navigationFieldToolbar!.isKind(of: NavigationFieldToolbar.self))
            }

            it("is nil at the beginning") {
                XCTAssertNil(self.navigationField.navigationFieldToolbar)
            }

            it("does not return custom inputAccessoryView") {
                self.navigationField.inputAccessoryView = UIView()
                XCTAssertNil(self.navigationField.navigationFieldToolbar)
            }
        }

        describe("applyInputAccessoryView") {

            it("creates the inputAccessoryView") {
                self.navigationField.applyInputAccessoryView()
                XCTAssertNotNil(self.navigationField.navigationFieldToolbar)
            }

            it("does not re-create the inputAccessoryView") {
                self.navigationField.applyInputAccessoryView()
                let inputAccessoryView = self.navigationField.inputAccessoryView
                self.navigationField.applyInputAccessoryView()
                XCTAssertEqual(inputAccessoryView, self.navigationField.inputAccessoryView)
            }
        }

        describe("delegate") {

            context("implements all methods") {
                var previousNavigationField: NavigationField!
                var nextNavigationField: NavigationField!
                var delegate: NavigationFieldDelegateFullImplementation!

                beforeEach {
                    previousNavigationField = UITextField()
                    nextNavigationField = UITextView()
                    previousNavigationField.nextNavigationField = self.navigationField
                    self.navigationField.nextNavigationField = nextNavigationField;
                    delegate = NavigationFieldDelegateFullImplementation()
                    (self.navigationField as? UITextField)?.delegate = delegate
                }

                it("calls the delegate method for the previous button") {
                    let previousButton = self.navigationField.navigationFieldToolbar!.previousButton
                    _ = previousButton.target!.perform(previousButton.action)
                    XCTAssert(delegate.previousButtonTapped)
                }

                it("calls the delegate method for the next button") {
                    let nextButton = self.navigationField.navigationFieldToolbar!.nextButton
                    _ = nextButton.target!.perform(nextButton.action)
                    XCTAssert(delegate.nextButtonTapped)
                }

                it("calls the delegate method for the done button") {
                    let doneButton = self.navigationField.navigationFieldToolbar!.doneButton
                    _ = doneButton.target!.perform(doneButton.action)
                    XCTAssert(delegate.doneButtonTapped)
                }
            }

            context("implements no methods") {
                var navigationField: MyTextView!
                var previousNavigationField: MyTextView!
                var nextNavigationField: MyTextView!
                var delegate: NavigationFieldDelegateEmptyImplementation!

                beforeEach {
                    navigationField = MyTextView()
                    previousNavigationField = MyTextView()
                    nextNavigationField = MyTextView()
                    previousNavigationField.nextNavigationField = navigationField
                    navigationField.nextNavigationField = nextNavigationField;
                    delegate = NavigationFieldDelegateEmptyImplementation()
                    navigationField.delegate = delegate
                }

                it("performs the default behavior when tapping the previous button") {
                    let previousButton = navigationField.navigationFieldToolbar!.previousButton
                    _ = previousButton.target!.perform(previousButton.action)
                    XCTAssert(previousNavigationField.becomeFirstResponderPerformed)
                }

                it("performs the default behavior when tapping the next button") {
                    let nextButton = navigationField.navigationFieldToolbar!.nextButton
                    _ = nextButton.target!.perform(nextButton.action)
                    XCTAssert(nextNavigationField.becomeFirstResponderPerformed)
                }

                it("performs the default behavior when tapping the done button") {
                    let doneButton = navigationField.navigationFieldToolbar!.doneButton
                    _ = doneButton.target!.perform(doneButton.action)
                    XCTAssert(navigationField.resignFirstResponderPerformed)
                }
            }
        }
    }
}
