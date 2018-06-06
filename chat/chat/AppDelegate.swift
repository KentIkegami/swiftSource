//
//  AppDelegate.swift
//  chat
//
//  Created by kent on 2017/10/28.
//  Copyright © 2017年 KENT IKEGAMI. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        let mainView: MainViewController = MainViewController()
        let NaviCon: UINavigationController = MyNavigationController(rootViewController: mainView)
        //バーの色
        UINavigationBar.appearance().barTintColor = UIColor.hex(ColorAll.COLOR_BASE,alpha: 1.0)
        //バーのテキストの色
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.hex(ColorAll.COLOR_FONT,alpha: 1.0)]
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.rootViewController = NaviCon
        self.window?.makeKeyAndVisible()
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
    }

    func applicationWillTerminate(_ application: UIApplication) {
    }


}

