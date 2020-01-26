//
//  AppDelegate.swift
//  HandiZapp
//
//  Created by vinoth kumar on 25/01/20.
//  Copyright © 2020 vinoth kumar. All rights reserved.
//

import UIKit
import CoreData
import IQKeyboardManager

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        IQKeyboardManager.shared().isEnabled = true

        return true
    }

}

