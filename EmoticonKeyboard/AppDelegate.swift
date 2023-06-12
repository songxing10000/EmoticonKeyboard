//
//  AppDelegate.swift
//  EmoticonKeyboard
//
//  Created by mac on 2023/6/12.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        let sb = UIStoryboard(name: "Main", bundle: nil)
        window?.rootViewController = sb.instantiateInitialViewController()
        window?.makeKeyAndVisible()
        return true
    }
 
}

