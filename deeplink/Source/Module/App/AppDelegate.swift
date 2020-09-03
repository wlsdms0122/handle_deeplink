//
//  AppDelegate.swift
//  deeplink
//
//  Created by Mackey on 2020/08/31.
//  Copyright © 2020 Mackey. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    let urlController = URLHandler()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = LaunchViewController(urlController: urlController)
        window.makeKeyAndVisible()
        
        self.window = window
        return true
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        urlController.handle(url: url)
    }
}
