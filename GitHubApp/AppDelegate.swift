//
//  AppDelegate.swift
//  GitHubApp
//
//  Created by 岩永 彩里 on 2018/09/25.
//  Copyright © 2018年 岩永 彩里. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        resetStateIfUITesting()
        // Override point for customization after application launch.
        return true
    }
    
    private func  resetStateIfUITesting() {
        if ProcessInfo.processInfo.arguments.contains("UITest") {
            print("成功")
            UserDefaults.standard.removePersistentDomain(forName: Bundle.main.bundleIdentifier!)
        }
        
    }
}
