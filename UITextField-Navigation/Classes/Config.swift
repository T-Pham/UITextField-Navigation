//
//  Config.swift
//  UITextField_Navigation
//
//  Created by Thanh Pham on 11/9/17.
//  Copyright © 2017 Thanh Pham. All rights reserved.
//

import UIKit

/// Config for the lib
public struct Config {

    /// The string used for the previousButton title
    public static var previousButtonTitle: String = {
        switch UIView.userInterfaceLayoutDirection(for: .unspecified) {
        case .leftToRight:
            return leftArrow
        case .rightToLeft:
            return rightArrow
        @unknown default:
            return "Previous"
        }
    }()

    /// The string used for the nextButton title
    public static var nextButtonTitle: String = {
        switch UIView.userInterfaceLayoutDirection(for: .unspecified) {
        case .leftToRight:
            return rightArrow
        case .rightToLeft:
            return leftArrow
        @unknown default:
            return "Next"
        }
    }()

    /// The string used for the doneButton title
    public static var doneButtonTitle: String = " ▼ "

    private static let leftArrow = " ❮ "
    private static let rightArrow = " ❯ "
}
