//
//  LogoutViewController.swift
//  iOSEx2Login
//
//  Created by Mylo Ho on 6/16/16.
//  Copyright © 2016 Ho Van Su. All rights reserved.
//

import UIKit

class LogoutViewController: UIViewController {
    
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate

    @IBOutlet weak var username: UILabel!
    
    //var usernameDefault: NSUserDefaults = NSUserDefaults()
    
    @IBAction func actionLogout(sender: AnyObject) {
        self.appDelegate.isLogout = true
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "HOME"
        
        //let username = usernameDefault.objectForKey("username")
        //self.username.text = "Welcome \(username!)!!!"
        
        let username = self.appDelegate.usernameSend
        self.username.text = "Welcome \(username!)!!"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
