//
//  AppDelegate.swift
//  iOSEx2Login
//
//  Created by Mylo Ho on 6/16/16.
//  Copyright © 2016 Ho Van Su. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    var usernameSend = String?()
    var isLogout = false

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        window = UIWindow(frame: UIScreen.mainScreen().bounds)
        if let window = window {
            
            let homeViewController = HomeViewController(nibName: "HomeViewController", bundle: nil)
            
            let navi = UINavigationController(rootViewController: homeViewController)
            
            window.rootViewController = navi
            
            window.backgroundColor = UIColor.whiteColor()
            window.makeKeyAndVisible()
        }
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
    }

    func applicationDidEnterBackground(application: UIApplication) {
       
    }

    func applicationWillEnterForeground(application: UIApplication) {
       
    }

    func applicationDidBecomeActive(application: UIApplication) {

    }

    func applicationWillTerminate(application: UIApplication) {
        
    }


}

