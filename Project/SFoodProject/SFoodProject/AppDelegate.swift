//
//  AppDelegate.swift
//  SFoodProject
//
//  Created by Mylo Ho on 7/4/16.
//  Copyright © 2016 Ho Van Su. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var loginNavigation: UINavigationController?
    var mainTabBar: UITabBarController?
    
    class func sharedInstance() -> AppDelegate {
        return UIApplication.sharedApplication().delegate as! AppDelegate
    }


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
        
        if let window = self.window {
            
            //init loginNavigation
            //init LoginViewController
            
            let loginViewController = LoginViewController(nibName: "LoginViewController", bundle: nil)
            self.loginNavigation = UINavigationController(rootViewController: loginViewController)
            
            //init mainTabBar
            //navi Home
            let homeNavigation = UINavigationController()
            let homeViewController = HomeTabBarViewController(nibName: "HomeTabBarViewController", bundle: nil)
            homeNavigation.viewControllers = [homeViewController]
            homeNavigation.title = "Home"
            homeNavigation.tabBarItem.image = UIImage(named: "home-logo")?.imageWithRenderingMode(.AlwaysTemplate)
            
            //navi Map
            let mapsNavigation = UINavigationController()
            let mapsViewController = MapsTabBarViewController(nibName: "MapsTabBarViewController", bundle: nil)
            mapsNavigation.viewControllers = [mapsViewController]
            mapsNavigation.title = "Maps"
            mapsNavigation.tabBarItem.image = UIImage(named: "map-icon")?.imageWithRenderingMode(.Automatic)

            //navi Favorite
            let favoriteNavigation = UINavigationController()
            let favoriteViewController = FavoriteTabBarViewController(nibName: "FavoriteTabBarViewController", bundle: nil)
            favoriteNavigation.viewControllers = [favoriteViewController]
            favoriteNavigation.title = "Favorite"
            favoriteNavigation.tabBarItem.image = UIImage(named: "bookmark-icon")?.imageWithRenderingMode(.Automatic)
            
            //navi Setting
            
            let settingsNavigation = UINavigationController()
            let settingsViewController = SettingTabBarViewController(nibName: "SettingTabBarViewController", bundle: nil)
            settingsNavigation.viewControllers = [settingsViewController]
            settingsNavigation.title = "Settings"
            settingsNavigation.tabBarItem.image = UIImage(named: "settings-icon")?.imageWithRenderingMode(.Automatic)
            
            
            //set mainTabBar
            self.mainTabBar = UITabBarController()
            self.mainTabBar?.viewControllers = [homeNavigation, favoriteNavigation, mapsNavigation, settingsNavigation]
            self.mainTabBar?.tabBar.tintColor = UIColor.orangeColor()
            self.mainTabBar?.tabBar.barTintColor = UIColor.whiteColor()
            
            
            //set rootViewController
            window.rootViewController = self.loginNavigation
            window.backgroundColor = UIColor.whiteColor()
            window.makeKeyAndVisible()
            
        }
        return true
    }
    
    func changeRootViewWhenLoginSuccess() {
        if let window = self.window {
            window.rootViewController = self.mainTabBar
        }
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

