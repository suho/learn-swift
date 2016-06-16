//
//  AppDelegate.swift
//  Ex1iOS
//
//  Created by Mylo Ho on 6/16/16.
//  Copyright © 2016 Ho Van Su. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.mainScreen().bounds)
        if let window = window {
            
            let homeViewController = HomeViewController(nibName: "HomeViewController", bundle: nil)
            
            window.rootViewController = homeViewController
            
            let tempFrame = CGRectMake(20, 20, 300, 150)
            let tempView = UIView(frame: tempFrame)
            tempView.backgroundColor = UIColor.blueColor()
            
            window.addSubview(tempView)
            
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

