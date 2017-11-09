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

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
//        UITextField_Navigation.Config.previousButtonTitle = "Previous"
//        UITextField_Navigation.Config.nextButtonTitle = "Next"
//        UITextField_Navigation.Config.doneButtonTitle = "Done"
        NavigationFieldToolbar.appearance().barStyle = .black
        NavigationFieldToolbar.appearance().backgroundColor = .purple
        if #available(iOS 11.0, *) {
            UIButton.appearance(whenContainedInInstancesOf: [NavigationFieldToolbar.self]).tintColor = .white
        } else {
            NavigationFieldToolbarButtonItem.appearance().tintColor = .white
        }
        return true
    }
}
