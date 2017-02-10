//
//  NavigationFieldInternal.swift
//  UITextField-Navigation
//
//  Created by Thanh Pham on 2/10/17.
//  Copyright © 2017 Thanh Pham. All rights reserved.
//

import UIKit

var NavigationFieldDelegateKey: Int8 = 0
var NextNavigationFieldKey: Int8 = 0
var PreviousNavigationFieldKey: Int8 = 0

protocol NavigationFieldInternal: NavigationField, NavigationFieldToolbarDelegate {

    var internal_delegate: AnyObject? { get }
    weak var internal_nextNavigationField: NavigationField? { get set }
    weak var internal_previousNavigationField: NavigationField? { get set }

    func internal_applyInputAccessoryView()

    func storeNavigationField(_ navigationField: NavigationField?, key: UnsafeRawPointer)
    func retrieveNavigationField(key: UnsafeRawPointer) -> NavigationField?
}

extension NavigationFieldInternal {

    weak var internal_nextNavigationField: NavigationField? {
        get {
            return retrieveNavigationField(key: &NextNavigationFieldKey)
        }

        set {
            if let navigationFieldInternal = nextNavigationField as? NavigationFieldInternal {
                navigationFieldInternal.internal_previousNavigationField = nil
            }
            storeNavigationField(newValue, key: &NextNavigationFieldKey)
            applyInputAccessoryView()
            if let newValue = newValue as? NavigationFieldInternal {
                newValue.internal_previousNavigationField = self
            }
        }
    }

    weak var internal_previousNavigationField: NavigationField? {
        get {
            return retrieveNavigationField(key: &PreviousNavigationFieldKey)
        }

        set {
            storeNavigationField(newValue, key: &PreviousNavigationFieldKey)
            applyInputAccessoryView()
        }
    }

    func navigationFieldToolbarDidTapPreviousButton(_ navigationFieldToolbar: NavigationFieldToolbar) {
        if let navigationFieldDelegate = internal_delegate as? NavigationFieldDelegate, let method = navigationFieldDelegate.navigationFieldDidTapPreviousButton {
            method(self)
        } else {
            previousNavigationField?.becomeFirstResponder()
        }
    }

    func navigationFieldToolbarDidTapNextButton(_ navigationFieldToolbar: NavigationFieldToolbar) {
        if let navigationFieldDelegate = internal_delegate as? NavigationFieldDelegate, let method = navigationFieldDelegate.navigationFieldDidTapNextButton {
            method(self)
        } else {
            nextNavigationField?.becomeFirstResponder()
        }
    }

    func navigationFieldToolbarDidTapDoneButton(_ navigationFieldToolbar: NavigationFieldToolbar) {
        if let navigationFieldDelegate = internal_delegate as? NavigationFieldDelegate, let method = navigationFieldDelegate.navigationFieldDidTapDoneButton {
            method(self)
        } else {
            resignFirstResponder()
        }
    }

    public func internal_applyInputAccessoryView() {
        if navigationFieldToolbar == nil {
            let navigationToolbar = NavigationFieldToolbar()
            navigationToolbar.navigationDelegate = self
            inputAccessoryView = navigationToolbar
        }

        navigationFieldToolbar?.previousButton.isEnabled = previousNavigationField != nil
        navigationFieldToolbar?.nextButton.isEnabled = nextNavigationField != nil
    }

    func storeNavigationField(_ navigationField: NavigationField?, key: UnsafeRawPointer) {
        if let navigationField = navigationField {
            objc_setAssociatedObject(self, key, WeakObjectContainer(object: navigationField), objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        } else {
            objc_setAssociatedObject(self, key, nil, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }

    func retrieveNavigationField(key: UnsafeRawPointer) -> NavigationField? {
        guard let weakObjectContainer = objc_getAssociatedObject(self, key) else {
            return nil
        }
        guard let navigationField = (weakObjectContainer as? WeakObjectContainer)?.object as? NavigationField else {
            storeNavigationField(nil, key: key)
            return nil
        }
        return navigationField
    }
}

extension UITextView: NavigationFieldInternal {

    var internal_delegate: AnyObject? {
        return delegate
    }
}

extension UITextField: NavigationFieldInternal {

    var internal_delegate: AnyObject? {
        return delegate
    }
}
