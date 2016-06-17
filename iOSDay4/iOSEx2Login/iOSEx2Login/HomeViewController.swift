//
//  HomeViewController.swift
//  iOSEx2Login
//
//  Created by Mylo Ho on 6/16/16.
//  Copyright © 2016 Ho Van Su. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var txtFieldUsername: UITextField!
    @IBOutlet weak var txtFieldPassword: UITextField!
    @IBOutlet weak var btnLogin: UIButton!
    
    //var usernameDefault: NSUserDefaults = NSUserDefaults()
    
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "LOGIN";
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    override func viewWillAppear(animated: Bool) {
        self.txtFieldUsername.text = ""
        self.txtFieldPassword.text = ""
        self.txtFieldUsername.becomeFirstResponder()
    }
    
    @IBAction func actionLogin(sender: AnyObject) {
        let username = self.txtFieldUsername.text
        let password = self.txtFieldPassword.text
        if checkLogin(username!, password: password!) {
            
            //usernameDefault.setObject(username, forKey: "username")
            
            self.appDelegate.usernameSend = username
            
            let login = LogoutViewController(nibName: "LogoutViewController", bundle: nil)
            self.navigationController?.pushViewController(login, animated: true)
            
        } else {
            if validUser(username!, password: password!) {
                showMessage("Input Not Valid!!")
            } else {
                showMessage("User Not Available!!")
            }
        }
    }
    
    
    func checkLogin(username: String, password: String) -> Bool {
        if (username == "admin" && password == "admin") || (username == "hovansu" && password == "hovansu") {
            return true
        } else {
            return false
        }
    }
    
    func validUser(username: String, password: String) -> Bool {
        if username == "" && password == "" {
            return true
        } else {
            return false
        }
    }
    
    func showMessage(message: String) -> Void {
        let alertController = UIAlertController(title: "Message", message: "\(message)", preferredStyle: UIAlertControllerStyle.Alert)
        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alertController, animated: true, completion: nil)
    }

}

extension HomeViewController: UITextFieldDelegate {
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if self.txtFieldPassword == textField {
            actionLogin(btnLogin)
        } else {
            self.txtFieldPassword.becomeFirstResponder()
        }
        return true
    }
}






