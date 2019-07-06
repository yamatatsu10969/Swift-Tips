//
//  AppDelegate.swift
//  UIKitStudy
//
//  Created by Tatsuya Yamamoto on 2019/7/5.
//  Copyright © 2019 山本竜也. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow()
        window?.makeKeyAndVisible()
        window?.rootViewController = UIButtonViewController.instantiate()
        return true
    }

}

