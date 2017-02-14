//
//  UITextFieldNavigationToolbarTests.swift
//  UITextField_Navigation
//
//  Created by Thanh Pham on 6/30/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import Quick
import UITextField_Navigation

class NavigationFieldToolbarTests: QuickSpec {
    var navigationToolbar: NavigationFieldToolbar!

    override func spec() {

        beforeEach() {
            let navigationField: NavigationField = UITextField()
            navigationField.applyInputAccessoryView()
            self.navigationToolbar = navigationField.navigationFieldToolbar
        }

        describe("UITextFieldNavigationToolbar") {

            it("has the previousButton") {
                XCTAssert(self.navigationToolbar.previousButton.isKind(of: NavigationFieldToolbarButtonItem.self))
            }

            it("has the nextButton") {
                XCTAssert(self.navigationToolbar.nextButton.isKind(of: NavigationFieldToolbarButtonItem.self))
            }

            it("has the doneButton") {
                XCTAssert(self.navigationToolbar.doneButton.isKind(of: NavigationFieldToolbarButtonItem.self))
            }

            it("disables init with coder") {
                XCTAssertNil(NavigationFieldToolbar(coder: NSCoder()))
            }
        }
    }
}
