//
//  AppDelegate.swift
//  Sofascore
//
//  Created by Luka Matešković on 14.03.2025..
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        let rootViewController: UINavigationController = .init(rootViewController: NavigationViewController())
        window?.rootViewController = rootViewController
        window?.makeKeyAndVisible()
    
        return true
    }
}

