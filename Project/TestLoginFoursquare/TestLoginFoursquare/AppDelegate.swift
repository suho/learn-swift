//
//  AppDelegate.swift
//  TestLoginFoursquare
//
//  Created by Mylo Ho on 8/29/16.
//  Copyright © 2016 Ho Van Su. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        window = UIWindow(frame: UIScreen.mainScreen().bounds)
        window?.rootViewController = HomeViewController(nibName: "HomeViewController", bundle: nil)
        window?.backgroundColor = UIColor.whiteColor()
        window?.makeKeyAndVisible()
        return true
    }

    func application(application: UIApplication, openURL url: NSURL, sourceApplication: String?, annotation: AnyObject) -> Bool {
        let homeViewController = window?.rootViewController as? HomeViewController
        homeViewController?.handleUrl(url)
        return true
    }

    func application(application: UIApplication, continueUserActivity userActivity: NSUserActivity, restorationHandler: ([AnyObject]?) -> Void) -> Bool {
        var didHandle = false
        if userActivity.activityType == NSUserActivityTypeBrowsingWeb {
            if let url = userActivity.webpageURL {
                let homeViewController = window?.rootViewController as? HomeViewController
                homeViewController?.handleUrl(url)
                didHandle = true
            }
        }
        return didHandle
    }

}

