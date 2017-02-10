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

    weak var internal_navigationFieldDelegate: NavigationFieldDelegate? { get set }
    weak var internal_nextNavigationField: NavigationField? { get set }
    weak var internal_previousNavigationField: NavigationField? { get set }

    func internal_applyInputAccessoryView()

    func storeObject(_ object: AnyObject?, key: UnsafeRawPointer)
    func retrieveObject(key: UnsafeRawPointer) -> AnyObject?
}

extension NavigationFieldInternal {

    weak var internal_navigationFieldDelegate: NavigationFieldDelegate? {
        get {
            return retrieveObject(key: &NavigationFieldDelegateKey) as? NavigationFieldDelegate
        }

        set {
            storeObject(newValue, key: &NavigationFieldDelegateKey)
        }
    }

    weak var internal_nextNavigationField: NavigationField? {
        get {
            return retrieveObject(key: &NextNavigationFieldKey) as? NavigationField
        }

        set {
            if let navigationFieldInternal = nextNavigationField as? NavigationFieldInternal {
                navigationFieldInternal.internal_previousNavigationField = nil
            }
            storeObject(newValue, key: &NextNavigationFieldKey)
            applyInputAccessoryView()
            if let newValue = newValue as? NavigationFieldInternal {
                newValue.internal_previousNavigationField = self
            }
        }
    }

    weak var internal_previousNavigationField: NavigationField? {
        get {
            return retrieveObject(key: &PreviousNavigationFieldKey) as? NavigationField
        }

        set {
            storeObject(newValue, key: &PreviousNavigationFieldKey)
            applyInputAccessoryView()
        }
    }

    func navigationFieldToolbarDidTapPreviousButton(_ navigationFieldToolbar: NavigationFieldToolbar) {
        if let navigationFieldDelegate = navigationFieldDelegate, let method = navigationFieldDelegate.navigationFieldDidTapPreviousButton {
            method(self)
        } else {
            previousNavigationField?.becomeFirstResponder()
        }
    }

    func navigationFieldToolbarDidTapNextButton(_ navigationFieldToolbar: NavigationFieldToolbar) {
        if let navigationFieldDelegate = navigationFieldDelegate, let method = navigationFieldDelegate.navigationFieldDidTapNextButton {
            method(self)
        } else {
            nextNavigationField?.becomeFirstResponder()
        }
    }

    func navigationFieldToolbarDidTapDoneButton(_ navigationFieldToolbar: NavigationFieldToolbar) {
        if let navigationFieldDelegate = navigationFieldDelegate, let method = navigationFieldDelegate.navigationFieldDidTapDoneButton {
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

    func storeObject(_ object: AnyObject?, key: UnsafeRawPointer) {
        if let object = object {
            objc_setAssociatedObject(self, key, WeakObjectContainer(object: object), objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        } else {
            objc_setAssociatedObject(self, key, nil, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }

    func retrieveObject(key: UnsafeRawPointer) -> AnyObject? {
        guard let weakObjectContainer = objc_getAssociatedObject(self, key) else {
            return nil
        }
        guard let object = (weakObjectContainer as? WeakObjectContainer)?.object else {
            storeObject(nil, key: key)
            return nil
        }
        return object
    }
}

extension UITextView: NavigationFieldInternal {}
extension UITextField: NavigationFieldInternal {}
