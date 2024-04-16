//
//  AppDelegate.swift
//  TestTaskIntersvyaz
//
//  Created by Вадим Игнатенко on 15.04.24.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let window = UIWindow()
        window.rootViewController = StartVC()
        window.makeKeyAndVisible()
        self.window = window
        return true
    }

}

