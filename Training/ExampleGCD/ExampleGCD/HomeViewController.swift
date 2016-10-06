//
//  HomeViewController.swift
//  ExampleGCD
//
//  Created by Mylo Ho on 9/23/16.
//  Copyright © 2016 Ho Van Su. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    class var sharedInstance: HomeViewController {
        struct Static {
            static var onceToken: dispatch_once_t = 0
            static var instance: HomeViewController? = nil
        }
        dispatch_once(&Static.onceToken) {
            Static.instance = HomeViewController()
        }
        return Static.instance!
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func asyncAction(sender: AnyObject) {
        self.dispatchAsyncWithQueue()
    }

    @IBAction func syncAction(sender: AnyObject) {
        dispatchSyncWithMainQueue()
    }

    func dispatchAsyncWithQueue() {
        let anyQueue = dispatch_queue_create("anyQueue", DISPATCH_QUEUE_CONCURRENT)
        var count = 0
        dispatch_async(anyQueue, {
            sleep(2)
            count = 10
        })
        print(count)
    }

    func dispatchSyncWithQueue() {
        let anyQueue = dispatch_queue_create("anyQueue", DISPATCH_QUEUE_CONCURRENT)
        var count = 0
        dispatch_sync(anyQueue, {
            sleep(2)
            count = 10
        })
        print(count)
    }

    func dispatchSyncWithMainQueue() {
        let mainQueue = dispatch_get_main_queue()
        var count = 0
        dispatch_sync(mainQueue) {
            sleep(2)
            count = 10
        }
        print(count)
    }

}
