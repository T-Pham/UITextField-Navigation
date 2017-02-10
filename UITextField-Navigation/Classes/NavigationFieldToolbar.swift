//
//  NavigationFieldToolbar.swift
//  UITextField-Navigation
//
//  Created by Thanh Pham on 2/10/17.
//  Copyright © 2017 Thanh Pham. All rights reserved.
//

import UIKit

protocol NavigationFieldToolbarDelegate: class {

    func navigationFieldToolbarDidTapPreviousButton(_ navigationFieldToolbar: NavigationFieldToolbar)
    func navigationFieldToolbarDidTapNextButton(_ navigationFieldToolbar: NavigationFieldToolbar)
    func navigationFieldToolbarDidTapDoneButton(_ navigationFieldToolbar: NavigationFieldToolbar)
}

/// Class for the `inputAccessoryView`.
public class NavigationFieldToolbar: UIToolbar {

    weak var navigationDelegate: NavigationFieldToolbarDelegate?

    /// Holds the previous button.
    public let previousButton: NavigationFieldToolbarButtonItem

    /// Holds the next button.
    public let nextButton: NavigationFieldToolbarButtonItem

    /// Holds the done button.
    public let doneButton: NavigationFieldToolbarButtonItem

    /// Has not been implemented. Use `init()` instead.
    required public init?(coder aDecoder: NSCoder) {
        return nil
    }

    init() {
        previousButton = NavigationFieldToolbarButtonItem(title: " ❮ ", style: .plain, target: nil, action: nil)
        nextButton = NavigationFieldToolbarButtonItem(title: " ❯ ", style: .plain, target: nil, action: nil)
        doneButton = NavigationFieldToolbarButtonItem(title: " ▼ ", style: .plain, target: nil, action: nil)

        super.init(frame: CGRect.zero)

        previousButton.isEnabled = false
        previousButton.target = self
        previousButton.action = #selector(previousButtonDidTap)
        nextButton.isEnabled = false
        nextButton.target = self
        nextButton.action = #selector(nextButtonDidTap)
        doneButton.target = self
        doneButton.action = #selector(doneButtonDidTap)

        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        items = [previousButton, nextButton, flexibleSpace, doneButton]
        sizeToFit()
    }

    func previousButtonDidTap() {
        if let navigationDelegate = navigationDelegate {
            navigationDelegate.navigationFieldToolbarDidTapPreviousButton(self)
        }
    }

    func nextButtonDidTap() {
        if let navigationDelegate = navigationDelegate {
            navigationDelegate.navigationFieldToolbarDidTapNextButton(self)
        }
    }

    func doneButtonDidTap() {
        if let navigationDelegate = navigationDelegate {
            navigationDelegate.navigationFieldToolbarDidTapDoneButton(self)
        }
    }
}
