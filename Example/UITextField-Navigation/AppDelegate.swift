//
//  AppDelegate.swift
//  UITextField-Navigation
//
//  Created by Thanh Pham on 06/19/2016.
//  Copyright (c) 2016 Thanh Pham. All rights reserved.
//

import UIKit
import UITextField_Navigation

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        UITextFieldNavigationToolbar.appearance().barStyle = .Black
        UITextFieldNavigationToolbar.appearance().backgroundColor = UIColor.purpleColor()
        UITextFieldNavigationToolbarButtonItem.appearance().tintColor = UIColor.whiteColor()
        return true
    }
}
